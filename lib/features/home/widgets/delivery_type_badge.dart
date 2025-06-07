import 'package:flutter/material.dart';

class DeliveryTypeBadge extends StatelessWidget {
  final String type;
  const DeliveryTypeBadge(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color text;
    switch (type) {
      case 'Delivery':
        bg = Colors.blue.shade50;
        text = Colors.blue;
        break;
      case 'Dining In':
        bg = Colors.brown.shade50;
        text = Colors.brown;
        break;
      case 'Fastest':
        bg = Colors.green.shade50;
        text = Colors.green;
        break;
      default:
        bg = Colors.grey.shade100;
        text = Colors.grey;
    }
    return Container(
      margin: const EdgeInsets.only(top: 2, right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        type,
        style: TextStyle(
          color: text,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
