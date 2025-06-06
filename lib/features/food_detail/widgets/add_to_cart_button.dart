import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final int quantity;
  final double total;
  final VoidCallback onAdd;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool enabled;
  final double bottomMargin;

  const AddToCartButton({
    required this.quantity,
    required this.total,
    required this.onAdd,
    required this.onIncrement,
    required this.onDecrement,
    this.enabled = true,
    this.bottomMargin = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFD4AF37);

    return Padding(
      padding: EdgeInsets.only(bottom: bottomMargin),
      child: quantity == 0
      // Add to Cart state
          ? SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: enabled ? onAdd : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: gold,
            foregroundColor: Colors.black,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          child: Row(
            children: [
              const Icon(Icons.add_shopping_cart, color: Colors.black),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Add to Cart',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4), // tiny right padding
            ],
          ),
        ),
      )
      // Quantity controller row
          : Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: gold, width: 1.1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: gold.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Quantity controls
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    quantity == 1 ? Icons.delete_outline : Icons.remove_circle_outline,
                    color: gold,
                    size: 28,
                  ),
                  onPressed: enabled ? onDecrement : null,
                  tooltip: quantity == 1 ? 'Remove from cart' : 'Decrease quantity',
                ),
                Container(
                  width: 36,
                  alignment: Alignment.center,
                  child: Text(
                    '$quantity',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: gold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: gold, size: 28),
                  onPressed: enabled ? onIncrement : null,
                  tooltip: 'Increase quantity',
                ),
              ],
            ),
            // Total price at right
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: gold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
