import 'package:flutter/material.dart';

const Color kAmber = Colors.amber;
const Color kBrown = Color(0xFF8D6748);

class RestaurantAdminDashboard extends StatelessWidget {
  const RestaurantAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Admin'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        children: [
          // BUSINESS PROFILE SECTION
          _SectionHeader("Business Profile"),
          Card(
            child: ListTile(
              leading: const Icon(Icons.store, color: kBrown),
              title: const Text("Restaurant Details"),
              subtitle: const Text("View and edit your profile"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: Edit profile */},
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.account_balance, color: kBrown),
              title: const Text("Bank & Payout Info"),
              subtitle: const Text("Manage payout details"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: Manage payout info */},
            ),
          ),
          const SizedBox(height: 16),

          // MENU & INVENTORY SECTION
          _SectionHeader("Menu & Inventory"),
          Card(
            child: ListTile(
              leading: const Icon(Icons.restaurant_menu, color: kBrown),
              title: const Text("Manage Menu"),
              subtitle: const Text("Add, edit, or remove food items"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: Manage menu */},
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.inventory_2, color: kBrown),
              title: const Text("Inventory Status"),
              subtitle: const Text("Update availability, stock, allergens"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: Inventory management */},
            ),
          ),
          const SizedBox(height: 16),

          // ORDER MANAGEMENT SECTION
          _SectionHeader("Orders"),
          Card(
            child: ListTile(
              leading: const Icon(Icons.receipt_long, color: kBrown),
              title: const Text("Current Orders"),
              subtitle: const Text("View and process incoming orders"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: View orders */},
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.history, color: kBrown),
              title: const Text("Order History"),
              subtitle: const Text("See all past orders"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: View history */},
            ),
          ),
          const SizedBox(height: 16),

          // PROMOS SECTION
          _SectionHeader("Promotions & Coupons"),
          Card(
            child: ListTile(
              leading: const Icon(Icons.local_offer, color: kBrown),
              title: const Text("Manage Promotions"),
              subtitle: const Text("Create or edit discounts and coupons"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: Promotions management */},
            ),
          ),
          const SizedBox(height: 16),

          // ANALYTICS SECTION
          _SectionHeader("Analytics & Reporting"),
          Card(
            child: ListTile(
              leading: const Icon(Icons.bar_chart, color: kBrown),
              title: const Text("View Analytics"),
              subtitle: const Text("Sales, popular items, customer stats"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: Analytics */},
            ),
          ),
          const SizedBox(height: 16),

          // REVIEWS SECTION
          _SectionHeader("Customer Engagement"),
          Card(
            child: ListTile(
              leading: const Icon(Icons.star, color: kBrown),
              title: const Text("Reviews & Ratings"),
              subtitle: const Text("View and respond to customer feedback"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: Reviews */},
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.campaign, color: kBrown),
              title: const Text("Send Announcements"),
              subtitle: const Text("Push updates to customers"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: Announcements */},
            ),
          ),
          const SizedBox(height: 16),

          // STAFF SECTION
          _SectionHeader("Staff Management"),
          Card(
            child: ListTile(
              leading: const Icon(Icons.people, color: kBrown),
              title: const Text("Manage Staff"),
              subtitle: const Text("Add or edit staff roles & access"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: Staff management */},
            ),
          ),
          const SizedBox(height: 16),

          // SETTINGS & SUPPORT SECTION
          _SectionHeader("Settings & Support"),
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings, color: kBrown),
              title: const Text("Settings & Preferences"),
              subtitle: const Text("Business hours, compliance, security"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: Settings */},
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.help_outline, color: kBrown),
              title: const Text("Help & Support"),
              subtitle: const Text("Get help or contact the platform"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {/* TODO: Support */},
            ),
          ),
          const SizedBox(height: 22),
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
