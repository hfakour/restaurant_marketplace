// cart/cart_app_bar.dart
// App bar for cart page.

import 'package:flutter/material.dart';

import '../../../core/theme/cart_styles.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
    title: const Text(
      'Your Cart',
      style: TextStyle(
        color: Colors.white,
        fontWeight: CartStyles.appBarFontWeight,
        fontSize: CartStyles.appBarFontSize,
        letterSpacing: -0.2,
      ),
    ),
    backgroundColor: CartStyles.charcoal,
    foregroundColor: Colors.white,
    scrolledUnderElevation: 0,
  );
}
