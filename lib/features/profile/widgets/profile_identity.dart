// profile/profile_identity.dart
// User name and "Premium Member" chip.

import 'package:flutter/material.dart';
import '../../../core/theme/profile_styles.dart';

class ProfileIdentity extends StatelessWidget {
  const ProfileIdentity({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Hassan Fakour',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w900,
          fontSize: 21,
          color: ProfileStyles.charcoal,
        ),
      ),
      const SizedBox(height: 7),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
        decoration: BoxDecoration(
          color: ProfileStyles.cardBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: ProfileStyles.charcoal.withValues(alpha: .1),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.workspace_premium,
                color: ProfileStyles.charcoal.withValues(alpha: 1), size: 17),
            const SizedBox(width: 3),
            Text(
              'Premium Member',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: ProfileStyles.charcoal.withValues(alpha: .7),
                fontWeight: FontWeight.w700,
                fontSize: 14.1,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
