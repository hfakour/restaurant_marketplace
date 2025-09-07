import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/address.dart';

/// A form to add or edit an address.
///
/// Includes a map picker that updates the address fields via reverse
/// geocoding when the user taps a location.  If an [address] is provided,
/// the form will be pre-populated and saving will emit an updated address.
class AddEditAddressScreen extends StatefulWidget {
  const AddEditAddressScreen({Key? key, this.address}) : super(key: key);
  final Address? address;

  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _postalCodeController;
  late TextEditingController _countryController;
  AddressLabel? _label;
  LatLng? _selectedLatLng;

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  // Opens a modal bottom sheet containing an interactive map.  When the
  // user taps on the map and confirms, returns the selected LatLng.
  Future<void> _pickLocation() async {
    final result = await showModalBottomSheet<LatLng>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return _MapPicker(initial: _selectedLatLng);
      },
    );
    if (result != null) {
      await _handleTap(result);
    }
  }

  @override
  void initState() {
    super.initState();
    _streetController = TextEditingController(text: widget.address?.street ?? '');
    _cityController = TextEditingController(text: widget.address?.city ?? '');
    _stateController = TextEditingController(text: widget.address?.state ?? '');
    _postalCodeController = TextEditingController(text: widget.address?.postalCode ?? '');
    _countryController = TextEditingController(text: widget.address?.country ?? '');
    _label = widget.address?.label;
    if (widget.address?.latitude != null && widget.address?.longitude != null) {
      _selectedLatLng = LatLng(widget.address!.latitude!, widget.address!.longitude!);
    }
  }

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _handleTap(LatLng latLng) async {
    setState(() => _selectedLatLng = latLng);
    try {
      final placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _streetController.text = [place.street, place.subLocality].where((s) => s != null && s!.isNotEmpty).join(' ');
          _cityController.text = place.locality ?? '';
          _stateController.text = place.administrativeArea ?? '';
          _postalCodeController.text = place.postalCode ?? '';
          _countryController.text = place.country ?? '';
        });
      }
    } catch (e) {
      // ignore geocoding errors; user can still type manually
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.address != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit address' : 'Add address'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Location picker summary and button
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(_selectedLatLng != null
                  ? 'Location: ${_selectedLatLng!.latitude.toStringAsFixed(5)}, ${_selectedLatLng!.longitude.toStringAsFixed(5)}'
                  : 'No location selected'),
              trailing: ElevatedButton(
                onPressed: _pickLocation,
                child: const Text('Pick location'),
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _streetController,
                    decoration: const InputDecoration(labelText: 'Street'),
                    validator: (value) => (value == null || value.isEmpty) ? 'Enter street' : null,
                  ),
                  TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(labelText: 'City'),
                    validator: (value) => (value == null || value.isEmpty) ? 'Enter city' : null,
                  ),
                  TextFormField(
                    controller: _stateController,
                    decoration: const InputDecoration(labelText: 'State'),
                  ),
                  TextFormField(
                    controller: _postalCodeController,
                    decoration: const InputDecoration(labelText: 'Postal code'),
                  ),
                    TextFormField(
                    controller: _countryController,
                    decoration: const InputDecoration(labelText: 'Country'),
                    validator: (value) => (value == null || value.isEmpty) ? 'Enter country' : null,
                  ),
                  DropdownButtonFormField<AddressLabel>(
                    value: _label,
                    decoration: const InputDecoration(labelText: 'Label'),
                    items: AddressLabel.values
                        .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                        .toList(),
                    onChanged: (val) => setState(() => _label = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final id = widget.address?.id ?? const Uuid().v4();
                  final address = Address(
                    id: id,
                    userId: widget.address?.userId ?? '',
                    street: _streetController.text.trim(),
                    city: _cityController.text.trim(),
                    state: _stateController.text.trim().isEmpty ? null : _stateController.text.trim(),
                    postalCode: _postalCodeController.text.trim(),
                    country: _countryController.text.trim(),
                    latitude: _selectedLatLng?.latitude,
                    longitude: _selectedLatLng?.longitude,
                    label: _label,
                    isDefault: widget.address?.isDefault ?? false,
                    createdAt: widget.address?.createdAt,
                    updatedAt: DateTime.now(),
                  );
                  Navigator.of(context).pop(address);
                }
              },
              child: Text(isEditing ? 'Save changes' : 'Add address'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom sheet map picker used to select a location via Google Maps.
class _MapPicker extends StatefulWidget {
  const _MapPicker({Key? key, this.initial}) : super(key: key);
  final LatLng? initial;

  @override
  State<_MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<_MapPicker> {
  LatLng? _picked;
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    _picked = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    // Height for bottom sheet: take up half the screen or more
    final height = MediaQuery.of(context).size.height * 0.6;
    return SafeArea(
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _picked ?? const LatLng(0, 0),
                  zoom: _picked != null ? 14 : 2,
                ),
                markers: _picked == null
                    ? <Marker>{}
                    : {
                        Marker(
                          markerId: const MarkerId('selected'),
                          position: _picked!,
                        ),
                      },
                onMapCreated: (c) {
                  if (!_controller.isCompleted) _controller.complete(c);
                },
                onTap: (latLng) => setState(() => _picked = latLng),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _picked == null
                          ? null
                          : () {
                              Navigator.of(context).pop(_picked);
                            },
                      child: const Text('Select location'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}