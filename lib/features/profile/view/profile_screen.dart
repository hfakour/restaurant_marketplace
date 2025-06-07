import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.black, // To match the reference
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // Profile card
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.brown[300],
                    child: Text(
                      "H", // Replace with user initial or network image
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Name, email, rating
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hassan Fakour', // Replace with actual user data
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Premium Member',
                          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            Text(
                              '4.9',
                              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '  (212 reviews)',
                              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // View/Edit button
                  TextButton(
                    onPressed: () {
                      // Navigate to profile edit
                    },
                    child: Text('Edit', style: TextStyle(color: Colors.amber[800])),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Account Actions / Info Section
          _ProfileSectionLabel(label: "Account"),
          _ProfileTile(
            icon: Icons.shopping_bag,
            title: 'Orders',
            subtitle: 'Your recent orders',
            onTap: () {},
          ),
          _ProfileTile(
            icon: Icons.favorite,
            title: 'Favorites',
            subtitle: 'Saved dishes & restaurants',
            onTap: () {},
          ),
          _ProfileTile(
            icon: Icons.credit_card,
            title: 'Payment Methods',
            subtitle: 'Manage your cards',
            onTap: () {},
          ),

          const SizedBox(height: 28),
          _ProfileSectionLabel(label: "Settings"),
          _ProfileTile(
            icon: Icons.settings,
            title: 'Preferences',
            subtitle: 'Language, notifications, more',
            onTap: () {},
          ),
          _ProfileTile(
            icon: Icons.verified_user,
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
          const SizedBox(height: 36),
          // Logout
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text('Logout', style: TextStyle(color: Colors.red)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileSectionLabel extends StatelessWidget {
  final String label;
  const _ProfileSectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4, left: 2),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

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
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
      leading: CircleAvatar(
        backgroundColor: Colors.amber[50],
        child: Icon(icon, color: Colors.amber[900]),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
