// features/home/widgets/carousel_section/restaurant_tag_chip.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/home_styles.dart';

class RestaurantTagChip extends StatelessWidget {
  final String tag;
  const RestaurantTagChip({required this.tag, super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: HomeStyles.subtleGray,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      tag,
      style: const TextStyle(
        color: HomeStyles.charcoal,
        fontWeight: FontWeight.w600,
        fontSize: 11.5,
      ),
    ),
  );
}
