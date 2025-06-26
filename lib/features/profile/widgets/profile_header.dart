// profile/profile_header.dart
// Top card: avatar, name, premium chip, edit button.

import 'package:flutter/material.dart';
import 'profile_avatar.dart';
import 'profile_identity.dart';
import '../../../core/theme/profile_styles.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    color: ProfileStyles.bgColor,
    padding: ProfileStyles.cardPad,
    child: Row(
      children: [
        ProfileAvatar(),
        const SizedBox(width: 22),
        const Expanded(child: ProfileIdentity()),
        Tooltip(
          message: 'Edit profile',
          child: TextButton(
            onPressed: () {}, // Connect to edit logic
            child: const Text(
              'Edit',
              style: TextStyle(
                color: ProfileStyles.charcoal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
