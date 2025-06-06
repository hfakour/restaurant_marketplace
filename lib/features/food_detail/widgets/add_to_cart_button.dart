import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final double total;
  final VoidCallback? onTap;
  final bool enabled;

  const AddToCartButton({
    required this.total,
    this.onTap,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onTap : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFD4AF37),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        'Add to Cart • \$${total.toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }
}
