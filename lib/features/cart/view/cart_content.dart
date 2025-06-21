// cart/cart_content.dart
// The main card area containing cart items and checkout.

import 'package:flutter/material.dart';
import '../../../core/theme/cart_styles.dart';
import '../../checkout/view/checkout_screen.dart';
import '../model/cart_model.dart';
import 'cart_item_row.dart';

class CartContent extends StatelessWidget {
  final List<CartItem> cartItems;
  final double total;
  const CartContent({required this.cartItems, required this.total, super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: CartStyles.cardBg,
      borderRadius: const BorderRadius.only(
        topLeft: CartStyles.sectionRadius,
        topRight: CartStyles.sectionRadius,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 18,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Padding(
      padding: CartStyles.cardPad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cart items list
          Expanded(
            child: ListView.separated(
              itemCount: cartItems.length,
              separatorBuilder: (_, __) => const Divider(
                height: 24,
                thickness: 0.65,
                color: Color(0x1F232325),
              ),
              itemBuilder: (context, i) => CartItemRow(item: cartItems[i]),
            ),
          ),
          // Checkout Button
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 8),
            child: SizedBox(
              width: double.infinity,
              height: CartStyles.checkoutBtnHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[700],
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(CartStyles.checkoutBtnRadius),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CheckoutScreen(),
                    ),
                  );
                },
                child: Text(
                  'Proceed to Checkout • \$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: CartStyles.checkoutBtnFontSize,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
