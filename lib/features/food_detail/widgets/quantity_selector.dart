import 'package:flutter/material.dart';

class FancyAddToCartButton extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove; // For trash icon

  const FancyAddToCartButton({
    required this.quantity,
    required this.onAdd,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFD4AF37);

    if (quantity == 0) {
      // Only show add to cart button
      return SizedBox(
        height: 48,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: gold,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          onPressed: onAdd,
          icon: const Icon(Icons.add_shopping_cart),
          label: const Text('Add to Cart'),
        ),
      );
    }

    // Otherwise, show trash/minus - quantity - plus UI
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: gold, width: 1.3),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: gold.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Left button: Trash (qty == 1), Minus (qty > 1)
          IconButton(
            icon: Icon(
              quantity == 1 ? Icons.delete_outline : Icons.remove_circle_outline,
              color: gold,
            ),
            onPressed: quantity == 1 ? onRemove : onDecrement,
            splashRadius: 22,
            tooltip: quantity == 1 ? 'Remove from cart' : 'Decrease quantity',
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '$quantity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: gold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          // Right button: Plus
          IconButton(
            icon: Icon(Icons.add_circle_outline, color: gold),
            onPressed: onIncrement,
            splashRadius: 22,
            tooltip: 'Increase quantity',
          ),
        ],
      ),
    );
  }
}
