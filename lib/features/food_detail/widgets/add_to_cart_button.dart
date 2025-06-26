import 'package:flutter/material.dart';

class AddToCartButton extends StatefulWidget {
  final double unitPrice;
  final double bottomPadding; // <-- renamed

  const AddToCartButton({
    required this.unitPrice,
    this.bottomPadding = 0,
    super.key,
  });

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFD4AF37);
    final total = widget.unitPrice * quantity;

    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomPadding), // <-- changed here
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, anim) =>
            FadeTransition(opacity: anim, child: child),
        child: quantity == 0
            ? SizedBox(
          key: const ValueKey('add'),
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () => setState(() => quantity = 1),
            style: ElevatedButton.styleFrom(
              backgroundColor: gold,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'Add to Cart • \$${widget.unitPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 18, color: Colors.black),
            ),
          ),
        )
            : Container(
          key: const ValueKey('quantity'),
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Quantity controls
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      quantity == 1
                          ? Icons.delete_outline
                          : Icons.remove_circle_outline,
                      color: gold,
                      size: 28,
                    ),
                    onPressed: () {
                      if (quantity == 1) {
                        setState(() => quantity = 0); // Go back to "Add to Cart"
                      } else {
                        setState(() => quantity--);
                      }
                    },
                    tooltip: quantity == 1
                        ? 'Remove from cart'
                        : 'Decrease quantity',
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
                    icon: Icon(Icons.add_circle_outline,
                        color: gold, size: 28),
                    onPressed: () => setState(() => quantity++),
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
      ),
    );
  }
}
