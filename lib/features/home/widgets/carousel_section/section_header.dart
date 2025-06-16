// features/home/widgets/carousel_section/section_header.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/home_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  const SectionHeader({required this.title, required this.icon, super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 2, bottom: 8),
    child: Row(
      children: [
        Icon(icon, color: HomeStyles.charcoal, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: HomeStyles.carouselSectionHeaderFontSize,
            color: HomeStyles.charcoal,
            letterSpacing: -0.5,
          ),
        ),
      ],
    ),
  );
}
