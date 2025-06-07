import 'package:flutter/material.dart';

const Color kAmber = Colors.amber;
const Color kBrown = Color(0xFF8D6748);

// ---- MOCK DATA ----
final _mockRestaurant = {
  "name": "Tokyo Bowl",
  "logo":
  "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
  "status": "Open",
};

final List<_FoodItem> _mockMenu = [
  _FoodItem(
      name: "Spicy Ramen",
      price: 9.5,
      image: "https://images.unsplash.com/photo-1464306076886-debca5e8a6b0"),
  _FoodItem(
      name: "Miso Soup",
      price: 3.5,
      image: "https://images.unsplash.com/photo-1504674900247-0877df9cc836"),
];

final List<_Order> _mockOrders = [
  _Order(
    id: "#3421",
    customer: "Hassan Fakour",
    total: 17.8,
    status: "Pending",
    date: DateTime.now().subtract(const Duration(minutes: 14)),
  ),
  _Order(
    id: "#3420",
    customer: "Alice",
    total: 12.2,
    status: "Preparing",
    date: DateTime.now().subtract(const Duration(hours: 1)),
  ),
];

// ---- MAIN ADMIN PANEL ----
class RestaurantAdminPanel extends StatefulWidget {
  const RestaurantAdminPanel({super.key});

  @override
  State<RestaurantAdminPanel> createState() => _RestaurantAdminPanelState();
}

class _RestaurantAdminPanelState extends State<RestaurantAdminPanel> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Panel'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          children: [
            // HEADER
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.network(
                    _mockRestaurant["logo"]!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _mockRestaurant["name"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: kBrown,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: _mockRestaurant["status"] == "Open"
                                ? Colors.green
                                : Colors.red,
                            size: 12,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _mockRestaurant["status"]!,
                            style: TextStyle(
                              color: _mockRestaurant["status"] == "Open"
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kAmber,
                    side: const BorderSide(color: kAmber),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    // TODO: Navigate to edit restaurant profile
                  },
                  icon: const Icon(Icons.edit, size: 19),
                  label: const Text("Edit"),
                ),
              ],
            ),
            const SizedBox(height: 26),
            // STATS CARDS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatsCard(
                  icon: Icons.attach_money,
                  label: "Revenue",
                  value: "\$204.30",
                ),
                _StatsCard(
                  icon: Icons.shopping_bag,
                  label: "Orders Today",
                  value: "23",
                ),
                _StatsCard(
                  icon: Icons.hourglass_top,
                  label: "Pending",
                  value: "3",
                ),
                _StatsCard(
                  icon: Icons.star,
                  label: "Popular",
                  value: "Ramen",
                ),
              ],
            ),
            const SizedBox(height: 26),
            // TABS
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(14),
              ),
              child: const TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3.5,
                    color: kAmber,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 28.0),
                ),
                labelColor: kAmber,
                unselectedLabelColor: kBrown,
                labelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                tabs: [
                  Tab(icon: Icon(Icons.restaurant_menu), text: "Menu"),
                  Tab(icon: Icon(Icons.receipt_long), text: "Orders"),
                  Tab(icon: Icon(Icons.bar_chart), text: "Analytics"),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 440, // Height for the tab content (scrollable if needed)
              child: const TabBarView(
                children: [
                  _MenuTab(),
                  _OrdersTab(),
                  _AnalyticsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---- STATS CARD ----
class _StatsCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _StatsCard(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 11),
        child: Column(
          children: [
            Icon(icon, color: kAmber, size: 24),
            const SizedBox(height: 7),
            Text(
              value,
              style: const TextStyle(
                  color: kBrown, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

// ---- MENU TAB ----
class _MenuTab extends StatelessWidget {
  const _MenuTab();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _mockMenu.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, i) {
        final item = _mockMenu[i];
        return Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.network(
                item.image,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(item.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: kBrown)),
            subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: kAmber),
                  onPressed: () {
                    // TODO: Edit food item
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red[800]),
                  onPressed: () {
                    // TODO: Delete food item
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ---- ORDERS TAB ----
class _OrdersTab extends StatelessWidget {
  const _OrdersTab();

  String _formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final ampm = dt.hour < 12 ? "AM" : "PM";
    return "$hour:${dt.minute.toString().padLeft(2, '0')} $ampm";
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _mockOrders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, i) {
        final o = _mockOrders[i];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              radius: 22,
              backgroundColor: kAmber.withOpacity(0.15),
              child: Icon(
                Icons.receipt_long,
                color: kAmber,
                size: 26,
              ),
            ),
            title: Text(
              o.id,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: kBrown, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${o.customer} • \$${o.total.toStringAsFixed(2)}"),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 2),
                    Text(_formatTime(o.date),
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
            trailing: _OrderStatusBadge(status: o.status),
            onTap: () {
              // TODO: Show order details
            },
          ),
        );
      },
    );
  }
}

class _OrderStatusBadge extends StatelessWidget {
  final String status;
  const _OrderStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case "Pending":
        color = Colors.amber;
        break;
      case "Preparing":
        color = Colors.blue;
        break;
      case "Delivered":
        color = Colors.green;
        break;
      case "Cancelled":
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
            color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}

// ---- ANALYTICS TAB (SIMPLE MOCKUP) ----
class _AnalyticsTab extends StatelessWidget {
  const _AnalyticsTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Analytics coming soon!",
        style: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}

// ---- MOCK DATA MODELS ----
class _FoodItem {
  final String name;
  final double price;
  final String image;
  _FoodItem({
    required this.name,
    required this.price,
    required this.image,
  });
}

class _Order {
  final String id;
  final String customer;
  final double total;
  final String status;
  final DateTime date;

  _Order({
    required this.id,
    required this.customer,
    required this.total,
    required this.status,
    required this.date,
  });
}
