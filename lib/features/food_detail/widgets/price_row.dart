import 'package:flutter/material.dart';

class PriceRow extends StatelessWidget {
  final double originalPrice;
  final double discountedPrice;
  final double discountPercent;
  final Color? highlightColor;

  const PriceRow({
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercent,
    this.highlightColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final gold = highlightColor ?? const Color(0xFFD4AF37);

    return Row(
      children: [
        Text(
          '\$${originalPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '\$${discountedPrice.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 24,
            color: gold,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '-${discountPercent.toInt()}%',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
