import 'package:flutter/material.dart';

const Color kAmber = Colors.amber;
const Color kBrown = Color(0xFF8D6748);

class EmployeeSalesPanel extends StatelessWidget {
  const EmployeeSalesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Dashboard'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () {
              // TODO: Handle logout
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        children: [
          // --- TODAY'S MENU ---
          _SectionHeader("Today's Menu"),
          Card(
            child: ListTile(
              leading: const Icon(Icons.restaurant_menu, color: kBrown),
              title: const Text("View Menu"),
              subtitle: const Text("Browse items for sale today"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: View menu */},
            ),
          ),
          const SizedBox(height: 16),

          // --- QUICK ORDER ENTRY ---
          _SectionHeader("New Sale"),
          Card(
            child: ListTile(
              leading: const Icon(Icons.point_of_sale, color: kBrown),
              title: const Text("Enter New Order"),
              subtitle: const Text("Create a walk-in or phone order"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: New order */},
            ),
          ),
          const SizedBox(height: 16),

          // --- ACTIVE ORDERS ---
          _SectionHeader("Active Orders"),
          Card(
            child: ListTile(
              leading: const Icon(Icons.receipt_long, color: kBrown),
              title: const Text("View Active Orders"),
              subtitle: const Text("Mark orders as ready or completed"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: View active orders */},
            ),
          ),
          const SizedBox(height: 16),

          // --- ORDER LOOKUP ---
          _SectionHeader("Find an Order"),
          Card(
            child: ListTile(
              leading: const Icon(Icons.search, color: kBrown),
              title: const Text("Order Lookup"),
              subtitle: const Text("Search orders by number or customer"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: Search orders */},
            ),
          ),
          const SizedBox(height: 22),

          // --- LOGOUT ---
          Center(
            child: TextButton.icon(
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text("Logout", style: TextStyle(color: Colors.red)),
              onPressed: () {
                // TODO: Handle logout
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- SECTION HEADER ---
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 6, top: 12),
    child: Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: kBrown,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    ),
  );
}
