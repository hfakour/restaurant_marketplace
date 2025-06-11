// profile_screen.dart
// Full-featured, production-ready profile screen using clean code architecture and extracted styles.
// Each UI section is modular, documented, and maintainable.

import 'package:flutter/material.dart';
import 'profile_styles.dart';

/// Root ProfileScreen widget.
/// Lays out the profile page with app bar, header, and content.
/// The header and content are split into private stateless widgets for clarity and reusability.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const _ProfileAppBar(),
    backgroundColor: ProfileStyles.bgColor,
    body: Column(
      children: const [
        _ProfileHeader(),     // Top profile card: avatar, name, edit
        Expanded(child: _ProfileContent()), // Main scrollable content
      ],
    ),
  );
}

/// Custom app bar for the profile screen.
/// Uses primary accent color for branding.
class _ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ProfileAppBar();

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

/// Top profile card showing avatar, name, premium chip, and edit button.
/// Layout is a Row for clean horizontal alignment.
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    color: ProfileStyles.bgColor,
    padding: ProfileStyles.cardPad,
    child: Row(
      children: [
        _ProfileAvatar(),                    // User profile picture
        const SizedBox(width: 22),
        const Expanded(child: _ProfileIdentity()), // Name and premium chip
        Tooltip(
          message: 'Edit profile',
          child: TextButton(
            onPressed: () {}, // Connect edit logic here
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

/// Circular avatar with border and drop shadow for a clean, modern look.
/// Semantics improves accessibility for screen readers.
class _ProfileAvatar extends StatelessWidget {
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
          "H", // Initial, but could be an image asset/network in production
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

/// Displays user's name and a minimal "Premium Member" chip.
/// Uses theme text styles for consistency with the app's design system.
class _ProfileIdentity extends StatelessWidget {
  const _ProfileIdentity();

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
            color: ProfileStyles.charcoal.withOpacity(0.08),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.workspace_premium,
                color: ProfileStyles.charcoal.withOpacity(0.6), size: 17),
            const SizedBox(width: 3),
            Text(
              'Premium Member',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: ProfileStyles.charcoal.withOpacity(0.6),
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

/// Main profile content area: account/settings sections and logout.
/// Scrollable, with top rounded corners for card feel.
class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

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
        child: _ProfileSections(),
      ),
    ),
  );
}

/// Lays out the Account, Settings, and Logout sections.
/// Each tile is its own widget for clarity and easy expansion.
class _ProfileSections extends StatelessWidget {
  const _ProfileSections();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _ProfileSectionLabel('Account'),
      _ProfileTile(
        icon: Icons.shopping_bag_outlined,
        title: 'Orders',
        subtitle: 'Your recent orders',
        onTap: () {},
      ),
      _ProfileTile(
        icon: Icons.favorite_border,
        title: 'Favorites',
        subtitle: 'Saved dishes & restaurants',
        onTap: () {},
      ),
      _ProfileTile(
        icon: Icons.credit_card_outlined,
        title: 'Payment Methods',
        subtitle: 'Manage your cards',
        onTap: () {},
      ),
      const _ProfileSectionLabel('Settings'),
      _ProfileTile(
        icon: Icons.settings_outlined,
        title: 'Preferences',
        subtitle: 'Language, notifications, more',
        onTap: () {},
      ),
      _ProfileTile(
        icon: Icons.security_outlined,
        title: 'Security',
        subtitle: 'Password & privacy',
        onTap: () {},
      ),
      _ProfileTile(
        icon: Icons.help_outline,
        title: 'Help & Support',
        subtitle: 'Get assistance',
        onTap: () {},
      ),
      const SizedBox(height: 10),
      _LogoutButton(onPressed: () {}),
    ],
  );
}

/// Bold label for each section: "Account", "Settings", etc.
/// Ensures clear separation between different groups of actions.
class _ProfileSectionLabel extends StatelessWidget {
  final String label;
  const _ProfileSectionLabel(this.label);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 3, top: 12, left: 2),
    child: Text(
      label,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: ProfileStyles.charcoal,
        fontWeight: FontWeight.w800,
        fontSize: 15.8,
        letterSpacing: -0.1,
      ),
    ),
  );
}

/// Individual tile for profile actions (orders, favorites, etc).
/// Highly reusable, with leading icon, title, subtitle, and trailing chevron.
class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
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
          color: ProfileStyles.charcoal.withOpacity(0.85),
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

/// Standalone, visually prominent logout button.
/// Designed to stand out with red accent and strong contrast.
class _LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _LogoutButton({required this.onPressed});

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
