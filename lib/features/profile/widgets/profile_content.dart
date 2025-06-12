// profile/profile_content.dart
// Main scrollable card area with account/settings/logout.

import 'package:flutter/material.dart';
import 'profile_sections.dart';
import '../../../core/theme/profile_styles.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: ProfileStyles.cardBg,
      borderRadius: const BorderRadius.only(
        topLeft: ProfileStyles.sectionRadius,
        topRight: ProfileStyles.sectionRadius,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 16,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: const Padding(
      padding: ProfileStyles.sectionPad,
      child: SingleChildScrollView(
        child: ProfileSections(),
      ),
    ),
  );
}
