// cart/cart_screen.dart
// Composes all cart widgets for the main cart page.

import 'package:flutter/material.dart';
import '../data/cart.mock.dart';
import 'cart_app_bar.dart';
import '../../../core/theme/cart_styles.dart';
import '../model/cart_model.dart';
import 'cart_address_card.dart';
import 'cart_content.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = mockCart;
    final total = cartItems.fold<double>(0.0, (t, item) => t + item.price * item.quantity);

    return Scaffold(
      appBar: const CartAppBar(),
      backgroundColor: CartStyles.bgColor,
      body: Column(
        children: [
          const CartAddressCard(
            name: 'Home',
            details: '123 Flutter Street, Springfield, USA',
          ),
          Expanded(
            child: CartContent(cartItems: cartItems, total: total),
          ),
        ],
      ),
    );
  }
}
