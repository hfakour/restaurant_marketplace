import 'package:flutter/material.dart';
import '../widgets/section_title.dart';
import '../widgets/gap.dart';

class Section extends StatelessWidget {
  final String title;
  final Widget child;
  const Section({required this.title, required this.child, super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SectionTitle(title, fontSize: 16),
      const Gap(4),
      child,
    ],
  );
}
