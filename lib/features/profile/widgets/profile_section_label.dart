// profile/profile_section_label.dart
// Bold label for separating profile sections.

import 'package:flutter/material.dart';
import '../../../core/theme/profile_styles.dart';

class ProfileSectionLabel extends StatelessWidget {
  final String label;
  const ProfileSectionLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 3, top: 3, left: 2),
    child: Text(
      label,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: ProfileStyles.charcoal,
        fontWeight: FontWeight.w800,
        fontSize: 15.8,
        letterSpacing: -0.1,
      ),
    ),
  );
}
