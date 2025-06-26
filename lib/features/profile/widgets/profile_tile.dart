// profile/profile_tile.dart
// List tile for each action on the profile.

import 'package:flutter/material.dart';
import '../../../core/theme/home_styles.dart';
import '../../../core/theme/profile_styles.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Semantics(
    label: '$title: $subtitle',
    button: true,
    child: ListTile(
      leading: Container(
        width: ProfileStyles.tileLeadSize,
        height: ProfileStyles.tileLeadSize,
        decoration: const BoxDecoration(
          color: ProfileStyles.tileIconBg,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          color:HomeStyles.charcoal,
          size: ProfileStyles.tileIconSize,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w800,
          color: ProfileStyles.charcoal,
          fontSize: 16.2,
          letterSpacing: -0.1,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: ProfileStyles.charcoal.withOpacity(0.5),
          fontWeight: FontWeight.w500,
          fontSize: 13.4,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0x52232325),
        size: 27,
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ProfileStyles.tileRadius),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      horizontalTitleGap: 15,
      minLeadingWidth: 0,
    ),
  );
}
