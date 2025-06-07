import 'package:flutter/material.dart';

class RestaurantStatusBadge extends StatelessWidget {
  final bool isOpen;
  const RestaurantStatusBadge({required this.isOpen, super.key});

  @override
  Widget build(BuildContext context) {
    final color = isOpen ? Colors.green : Colors.red;
    final bg = isOpen ? Colors.green.shade50 : Colors.red.shade50;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isOpen ? 'Open' : 'Closed',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
