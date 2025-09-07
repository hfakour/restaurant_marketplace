import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/address.dart';
import '../bloc/address_bloc.dart';
import 'add_edit_address_screen.dart';

/// Displays the list of addresses for the user.
///
/// The default address appears at the top with a pin icon.  Long press on any
/// address to mark it as the default.  Tap an address to edit it.  Use the
/// floating action button to add a new address.
class AddressListScreen extends StatelessWidget {
  const AddressListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Addresses')),
      body: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          if (state is AddressLoading || state is AddressInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddressError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is AddressLoaded) {
            final addresses = state.addresses;
            if (addresses.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_off, size: 48),
                    const SizedBox(height: 16),
                    const Text('No addresses yet'),
                    const SizedBox(height: 8),
                    const Text('Add your first address using the + button'),
                  ],
                ),
              );
            }
            // sort addresses so default appears first
            final sorted = List<Address>.from(addresses);
            sorted.sort((a, b) => (b.isDefault ? 1 : 0) - (a.isDefault ? 1 : 0));
            return ListView.builder(
              itemCount: sorted.length,
              itemBuilder: (context, index) {
                final addr = sorted[index];
                return AddressTile(address: addr);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to add address screen
          final bloc = context.read<AddressBloc>();
          final result = await Navigator.of(context).push(
            MaterialPageRoute<Address?>(
              builder: (_) => AddEditAddressScreen(),
            ),
          );
          if (result != null) {
            bloc.add(AddAddressEvent(result));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Widget to display a single address row.
class AddressTile extends StatelessWidget {
  const AddressTile({Key? key, required this.address}) : super(key: key);
  final Address address;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddressBloc>();
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(address.isDefault ? Icons.push_pin : Icons.location_on),
      title: Text(address.street.isNotEmpty
          ? '${address.street}, ${address.city}'
          : 'Unnamed address'),
      subtitle: Text('${address.postalCode}, ${address.country}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Delete icon
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              bloc.add(DeleteAddressEvent(address.id));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Address deleted')),
              );
            },
          ),
          // Default icon indicator
          if (address.isDefault)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(Icons.star, color: theme.colorScheme.primary),
            ),
        ],
      ),
      onTap: () async {
        // edit the address
        final updated = await Navigator.of(context).push<Address?>(
          MaterialPageRoute(
            builder: (_) => AddEditAddressScreen(address: address),
          ),
        );
        if (updated != null) {
          bloc.add(UpdateAddressEvent(updated));
        }
      },
      onLongPress: () {
        // set default
        bloc.add(SetDefaultAddressEvent(address.id));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Set as default address')),
        );
      },
    );
  }
}