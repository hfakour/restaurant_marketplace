// profile/profile_logout_button.dart
// Visually prominent logout button.

import 'package:flutter/material.dart';
import '../../../core/theme/profile_styles.dart';

class ProfileLogoutButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ProfileLogoutButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: ProfileStyles.logoutBtnHeight,
    child: OutlinedButton.icon(
      icon: const Icon(Icons.logout, color: Colors.redAccent, size: 21),
      label: const Text(
        'Logout',
        style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.w700,
          fontSize: 17.5,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.redAccent, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ProfileStyles.logoutBtnRadius),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
    ),
  );
}
