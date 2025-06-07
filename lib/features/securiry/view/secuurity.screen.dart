import 'package:flutter/material.dart';

const Color kAmber = Colors.amber;
const Color kBrown = Color(0xFF8D6748);

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _twoStepEnabled = true;
  bool _biometricEnabled = false;

  void _showChangePasswordDialog() async {
    // Normally you would push to a change password screen.
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Password"),
        content: const Text("Here you would navigate to your Change Password flow."),
        actions: [
          TextButton(
            child: const Text("Close"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _confirmLogoutEverywhere() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Log out everywhere?"),
        content: const Text(
            "Are you sure you want to log out of all devices? This will end your sessions everywhere."),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text("Log out"),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      // TODO: Call logout everywhere API/provider
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out everywhere!')),
      );
    }
  }

  void _confirmDeleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text(
          "This action is irreversible. Are you sure you want to delete your account?",
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text("Delete"),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      // TODO: Call account deletion logic/provider
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account deleted.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        children: [
          _SectionHeader(title: "Security"),
          ListTile(
            leading: const Icon(Icons.lock_outline, color: kBrown),
            title: const Text("Change password"),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: _showChangePasswordDialog,
          ),
          SwitchListTile(
            value: _twoStepEnabled,
            onChanged: (v) => setState(() => _twoStepEnabled = v),
            activeColor: kAmber,
            title: const Text("Enable 2-step verification"),
            secondary: const Icon(Icons.verified_user_outlined, color: kBrown),
          ),
          SwitchListTile(
            value: _biometricEnabled,
            onChanged: (v) => setState(() => _biometricEnabled = v),
            activeColor: kAmber,
            title: const Text("Biometric authentication"),
            secondary: const Icon(Icons.fingerprint, color: kBrown),
          ),

          const SizedBox(height: 32),
          _SectionHeader(title: "Session"),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: Text(
              "Log out everywhere",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: _confirmLogoutEverywhere,
          ),
          const SizedBox(height: 32),
          _SectionHeader(title: "Danger Zone"),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: Text(
              "Delete account",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: _confirmDeleteAccount,
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: kBrown,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.3,
        ),
      ),
    );
  }
}
