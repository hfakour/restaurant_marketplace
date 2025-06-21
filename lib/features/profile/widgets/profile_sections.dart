// profile/profile_sections.dart
// The main list of sections and actions for the profile.

import 'package:flutter/material.dart';
import '../../favorite/view/favorite_screen.dart';
import '../../help_and_support/view/help_and_support.screen.dart';
import '../../orders/view/orders_screen.dart';
import '../../preference/view/preference.screen.dart';
import '../../securiry/view/secuurity.screen.dart';
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrdersScreen()),
          );
        },
      ),
      ProfileTile(
        icon: Icons.favorite_border,
        title: 'Favorites',
        subtitle: 'Saved dishes & restaurants',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FavoriteScreen()),
          );
        },
      ),
      ProfileTile(
        icon: Icons.table_bar,
        title: 'Reservations',
        subtitle: 'Manage your reservations',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrdersScreen()),
            );
          },
      ),
      const ProfileSectionLabel('Settings'),
      ProfileTile(
        icon: Icons.settings_outlined,
        title: 'Preferences',
        subtitle: 'Language, notifications, more',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PreferencesScreen()),
          );
        },
      ),
      ProfileTile(
        icon: Icons.security_outlined,
        title: 'Security',
        subtitle: 'Password & privacy',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecurityScreen()),
          );
        },
      ),
      ProfileTile(
        icon: Icons.help_outline,
        title: 'Help & Support',
        subtitle: 'Get assistance',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HelpSupportScreen()),
          );
        },
      ),
      const SizedBox(height: 10),
      ProfileLogoutButton(onPressed: () {}),
    ],
  );
}
