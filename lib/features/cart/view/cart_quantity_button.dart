// cart/cart_quantity_button.dart
// Button for adjusting cart item quantity.

import 'package:flutter/material.dart';
import '../../../core/theme/cart_styles.dart';

class CartQuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color iconColor;
  const CartQuantityButton({
    required this.icon,
    required this.onPressed,
    this.iconColor = Colors.amber,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: CartStyles.quantityButtonSize,
    height: CartStyles.quantityButtonSize,
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: CartStyles.subtleGray,
      ),
      onPressed: onPressed,
      child: Icon(icon, size: CartStyles.quantityIconSize, color: iconColor),
    ),
  );
}
