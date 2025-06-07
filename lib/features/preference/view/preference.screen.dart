import 'package:flutter/material.dart';

// ----- COLORS -----
const Color kAmber = Colors.amber;
const Color kBrown = Color(0xFF8D6748);

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  bool _notifications = true;
  String _themeMode = 'system'; // 'system', 'light', 'dark'
  String _language = 'English';

  void _showThemeDialog() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text("App Theme"),
        children: [
          RadioListTile<String>(
            value: 'system',
            groupValue: _themeMode,
            onChanged: (v) => Navigator.pop(context, v),
            title: const Text("System"),
          ),
          RadioListTile<String>(
            value: 'light',
            groupValue: _themeMode,
            onChanged: (v) => Navigator.pop(context, v),
            title: const Text("Light"),
          ),
          RadioListTile<String>(
            value: 'dark',
            groupValue: _themeMode,
            onChanged: (v) => Navigator.pop(context, v),
            title: const Text("Dark"),
          ),
        ],
      ),
    );
    if (selected != null && selected != _themeMode) {
      setState(() => _themeMode = selected);
      // TODO: Apply theme via provider/settings
    }
  }

  void _showLanguageDialog() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text("Choose Language"),
        children: [
          RadioListTile<String>(
            value: 'English',
            groupValue: _language,
            onChanged: (v) => Navigator.pop(context, v),
            title: const Text("English"),
          ),
          RadioListTile<String>(
            value: 'Polski',
            groupValue: _language,
            onChanged: (v) => Navigator.pop(context, v),
            title: const Text("Polski"),
          ),
          // Add more languages here...
        ],
      ),
    );
    if (selected != null && selected != _language) {
      setState(() => _language = selected);
      // TODO: Apply language
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        children: [
          // ---- ACCOUNT SECTION ----
          _SectionHeader(title: "Account"),
          ListTile(
            leading: const Icon(Icons.language, color: kBrown),
            title: const Text("Language"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_language, style: TextStyle(color: kBrown)),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            onTap: _showLanguageDialog,
          ),
          SwitchListTile(
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
            activeColor: kAmber,
            title: const Text("Enable Notifications"),
            secondary: const Icon(Icons.notifications_active, color: kBrown),
          ),

          const SizedBox(height: 28),
          // ---- APP SECTION ----
          _SectionHeader(title: "App"),
          ListTile(
            leading: const Icon(Icons.color_lens, color: kBrown),
            title: const Text("Theme"),
            subtitle: Text(
              _themeMode[0].toUpperCase() + _themeMode.substring(1),
              style: const TextStyle(color: kBrown),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: _showThemeDialog,
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
