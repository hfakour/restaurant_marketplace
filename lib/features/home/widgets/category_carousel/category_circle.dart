// features/home/widgets/category_carousel/category_circle.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/home_styles.dart';

class CategoryCircle extends StatelessWidget {
  final String label;
  final IconData iconData;
  const CategoryCircle({required this.label, required this.iconData, super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        decoration: BoxDecoration(
          color: HomeStyles.subtleGray,
          shape: BoxShape.circle,
          border: Border.all(color: HomeStyles.charcoal.withOpacity(0.08), width: 1.1),
        ),
        child: CircleAvatar(
          backgroundColor: HomeStyles.cardBg,
          radius: HomeStyles.categoryCircleRadius,
          child: Icon(iconData, color:HomeStyles.charcoal, size: 24),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: HomeStyles.charcoal.withOpacity(0.80),
          fontSize: 13.1,
          letterSpacing: -0.2,
        ),
      ),
    ],
  );
}
