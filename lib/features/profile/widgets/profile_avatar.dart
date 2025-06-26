// profile/profile_avatar.dart
// Circular user avatar with border and drop shadow.

import 'package:flutter/material.dart';
import '../../../core/theme/profile_styles.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Profile picture: Hassan Fakour',
    image: true,
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: ProfileStyles.avatarBorder,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: ProfileStyles.avatarRadius,
        backgroundColor: ProfileStyles.charcoal,
        child: Text(
          "H",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 38,
            letterSpacing: -1.2,
          ),
        ),
      ),
    ),
  );
}
