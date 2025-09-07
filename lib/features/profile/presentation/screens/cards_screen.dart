import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';
import '../../domain/entities/user_profile.dart';

/// Screen to manage payment cards. Displays all saved payment methods and
/// allows the user to set a default card or delete a card.  Adding new
/// cards is not implemented here but could be accessed via a separate screen.
class CardsScreen extends StatelessWidget {
  const CardsScreen({Key? key, required this.user}) : super(key: key);
  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    final methods = user.paymentMethodRefs;
    final profileBloc = context.read<ProfileBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text('Your cards')),
      body: methods.isEmpty
          ? const Center(child: Text('No payment methods'))
          : ListView.builder(
              itemCount: methods.length,
              itemBuilder: (context, index) {
                final method = methods[index];
                final brand = method.brand ?? 'Card';
                final last4 = method.last4 ?? '••••';
                final isDefault = method.isDefault || (index == 0 && !methods.any((m) => m.isDefault));
                return ListTile(
                  leading: CircleAvatar(child: Text(brand.characters.first.toUpperCase())),
                  title: Text('$brand •••• $last4'),
                  subtitle: Text('#${method.paymentMethodId}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isDefault
                          ? const Chip(label: Text('Default'))
                          : OutlinedButton(
                              onPressed: () {
                                profileBloc.add(MakeDefaultPaymentMethod(method.paymentMethodId));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Set ${method.last4 ?? 'card'} as default')),
                                );
                              },
                              child: const Text('Make default'),
                            ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          // TODO: implement deletion logic
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Delete card not implemented')),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}