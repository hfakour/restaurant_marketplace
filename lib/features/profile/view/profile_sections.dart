// profile/profile_sections.dart
// The main list of sections and actions for the profile.

import 'package:flutter/material.dart';
import 'profile_section_label.dart';
import 'profile_tile.dart';
import 'profile_logout_button.dart';

class ProfileSections extends StatelessWidget {
  const ProfileSections({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const ProfileSectionLabel('Account'),
      ProfileTile(
        icon: Icons.shopping_bag_outlined,
        title: 'Orders',
        subtitle: 'Your recent orders',
        onTap: () {},
      ),
      ProfileTile(
        icon: Icons.favorite_border,
        title: 'Favorites',
        subtitle: 'Saved dishes & restaurants',
        onTap: () {},
      ),
      ProfileTile(
        icon: Icons.credit_card_outlined,
        title: 'Payment Methods',
        subtitle: 'Manage your cards',
        onTap: () {},
      ),
      const ProfileSectionLabel('Settings'),
      ProfileTile(
        icon: Icons.settings_outlined,
        title: 'Preferences',
        subtitle: 'Language, notifications, more',
        onTap: () {},
      ),
      ProfileTile(
        icon: Icons.security_outlined,
        title: 'Security',
        subtitle: 'Password & privacy',
        onTap: () {},
      ),
      ProfileTile(
        icon: Icons.help_outline,
        title: 'Help & Support',
        subtitle: 'Get assistance',
        onTap: () {},
      ),
      const SizedBox(height: 10),
      ProfileLogoutButton(onPressed: () {}),
    ],
  );
}
