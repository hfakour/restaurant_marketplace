// profile/profile_screen.dart
// Root widget for the Profile page. Assembles header and content.

import 'package:flutter/material.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_content.dart';
import '../../../core/theme/profile_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const ProfileAppBar(),
    backgroundColor: ProfileStyles.bgColor,
    body: Column(
      children: const [
        ProfileHeader(),
        Expanded(child: ProfileContent()),
      ],
    ),
  );
}
