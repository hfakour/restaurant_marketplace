import 'package:flutter/material.dart';

const Color kAmber = Colors.amber;
const Color kBrown = Color(0xFF8D6748);

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        children: [
          // --- CONTACT US ---
          _SectionHeader(title: "Contact us"),
          ListTile(
            leading: const Icon(Icons.email_outlined, color: kBrown),
            title: const Text("Email Support"),
            subtitle: const Text("support@marketplace.com"),
            onTap: () {
              // TODO: Launch email intent
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone, color: kBrown),
            title: const Text("Call Us"),
            subtitle: const Text("+1 800 123 4567"),
            onTap: () {
              // TODO: Launch call intent
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat_bubble_outline, color: kBrown),
            title: const Text("Live Chat (WhatsApp)"),
            subtitle: const Text("+1 800 987 6543"),
            onTap: () {
              // TODO: Open WhatsApp or chat
            },
          ),
          const SizedBox(height: 26),

          // --- FAQ ---
          _SectionHeader(title: "Frequently Asked"),
          _FaqExpansion(),
          const SizedBox(height: 30),

          // --- SUBMIT A REQUEST ---
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: kAmber,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              elevation: 1,
            ),
            icon: const Icon(Icons.edit_note),
            label: const Text("Submit a Request"),
            onPressed: () {
              // TODO: Open a request form or send an email
            },
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

// ------- FAQ LIST (Expandable) -------
class _FaqExpansion extends StatefulWidget {
  @override
  State<_FaqExpansion> createState() => _FaqExpansionState();
}

class _FaqExpansionState extends State<_FaqExpansion> {
  final List<bool> _expanded = List.generate(_faqs.length, (_) => false);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (index, isExpanded) {
        setState(() => _expanded[index] = !isExpanded);
      },
      animationDuration: const Duration(milliseconds: 300),
      elevation: 1,
      children: [
        for (var i = 0; i < _faqs.length; i++)
          ExpansionPanel(
            isExpanded: _expanded[i],
            canTapOnHeader: true,
            backgroundColor: Colors.white,
            headerBuilder: (context, isOpen) => ListTile(
              title: Text(_faqs[i]['q']!, style: const TextStyle(color: kBrown, fontWeight: FontWeight.w600)),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(_faqs[i]['a']!, style: const TextStyle(color: Colors.black87)),
            ),
          ),
      ],
    );
  }
}

// ------- EXAMPLE FAQS -------
const List<Map<String, String>> _faqs = [
  {
    'q': "How can I reset my password?",
    'a': "Go to the Security screen in Preferences, tap Change Password and follow the instructions.",
  },
  {
    'q': "How do I track my order?",
    'a': "Open the Orders tab and tap on your order to view real-time tracking details.",
  },
  {
    'q': "How do I contact support?",
    'a': "Use the email, phone, or live chat options above, or submit a request via this screen.",
  },
  {
    'q': "Can I cancel or modify my order?",
    'a': "You can cancel or edit your order if it hasn't been prepared yet. Go to your Orders and check the options.",
  },
];

