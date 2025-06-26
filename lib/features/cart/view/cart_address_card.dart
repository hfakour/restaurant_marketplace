// cart/cart_address_card.dart
// The fixed address section at the top of the cart.

import 'package:flutter/material.dart';
import '../../../core/theme/cart_styles.dart';

class CartAddressCard extends StatelessWidget {
  final String name;
  final String details;

  const CartAddressCard({required this.name, required this.details, super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    color: CartStyles.bgColor,
    padding: CartStyles.addressPad,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: CartStyles.addressTitleWeight,
            color: CartStyles.charcoal,
            fontSize: CartStyles.addressTitleFontSize,
            letterSpacing: -0.1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          details,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: CartStyles.charcoal.withOpacity(0.5),
            fontWeight: FontWeight.w500,
            fontSize: 14.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
