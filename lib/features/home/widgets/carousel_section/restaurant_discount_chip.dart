// features/home/widgets/carousel_section/restaurant_discount_chip.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/home_styles.dart';

class RestaurantDiscountChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color? textColor;

  const RestaurantDiscountChip({
    required this.label,
    required this.color,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(
      color: color is MaterialColor ? color.withOpacity(0.14) : color,
      borderRadius: BorderRadius.circular(5.5),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: textColor ?? color,
        fontWeight: FontWeight.w700,
        fontSize: 12.3,
      ),
    ),
  );
}
