// profile/profile_app_bar.dart
// The top AppBar for the profile page.

import 'package:flutter/material.dart';
import '../../../core/theme/profile_styles.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
    title: const Text(
      'Profile',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 22,
      ),
    ),
    backgroundColor: ProfileStyles.charcoal,
    foregroundColor: Colors.white,
    centerTitle: false,
    elevation: 0,
  );
}
