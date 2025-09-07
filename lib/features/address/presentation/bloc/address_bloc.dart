import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/address.dart';
import '../../domain/usecases/add_address.dart';
import '../../domain/usecases/delete_address.dart';
import '../../domain/usecases/get_addresses.dart';
import '../../domain/usecases/update_address.dart';

part 'address_event.dart';
part 'address_state.dart';

/// BLoC that manages the list of addresses and default selection.
class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc({
    required GetAddresses getAddresses,
    required AddAddress addAddress,
    required UpdateAddress updateAddress,
    required DeleteAddress deleteAddress,
    required this.userId,
  })  : _getAddresses = getAddresses,
        _addAddress = addAddress,
        _updateAddress = updateAddress,
        _deleteAddress = deleteAddress,
        super(const AddressInitial()) {
    on<LoadAddresses>(_onLoad);
    on<AddAddressEvent>(_onAdd);
    on<DeleteAddressEvent>(_onDelete);
    on<UpdateAddressEvent>(_onUpdate);
    on<SetDefaultAddressEvent>(_onSetDefault);
  }

  final GetAddresses _getAddresses;
  final AddAddress _addAddress;
  final UpdateAddress _updateAddress;
  final DeleteAddress _deleteAddress;
  final String userId;

  Future<void> _onLoad(LoadAddresses event, Emitter<AddressState> emit) async {
    emit(const AddressLoading());
    try {
      final addresses = await _getAddresses(userId);
      emit(AddressLoaded(List<Address>.from(addresses)));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> _onAdd(AddAddressEvent event, Emitter<AddressState> emit) async {
    if (state is! AddressLoaded) return;
    final current = (state as AddressLoaded).addresses;
    // ensure id is set if blank
    final newAddress = event.address.id.isEmpty
        ? event.address.copyWith(id: const Uuid().v4(), userId: userId)
        : event.address;
    await _addAddress(newAddress);
    add(LoadAddresses());
  }

  Future<void> _onDelete(
      DeleteAddressEvent event, Emitter<AddressState> emit) async {
    await _deleteAddress(event.addressId);
    add(LoadAddresses());
  }

  Future<void> _onUpdate(
      UpdateAddressEvent event, Emitter<AddressState> emit) async {
    await _updateAddress(event.address);
    add(LoadAddresses());
  }

  Future<void> _onSetDefault(
      SetDefaultAddressEvent event, Emitter<AddressState> emit) async {
    if (state is! AddressLoaded) return;
    final loaded = state as AddressLoaded;
    final addresses = List<Address>.from(loaded.addresses);
    // set new default and clear previous default
    for (var i = 0; i < addresses.length; i++) {
      final addr = addresses[i];
      if (addr.id == event.addressId && addr.isDefault != true) {
        addresses[i] = addr.copyWith(isDefault: true);
        await _updateAddress(addresses[i]);
      } else if (addr.id != event.addressId && addr.isDefault == true) {
        addresses[i] = addr.copyWith(isDefault: false);
        await _updateAddress(addresses[i]);
      }
    }
    add(LoadAddresses());
  }
}