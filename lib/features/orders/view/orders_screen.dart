import 'package:flutter/material.dart';

// Mock order data structure (replace with your real provider/model)
class OrderItem {
  final String foodName;
  final String restaurant;
  final String imageUrl;
  final DateTime dateTime;
  final double price;
  final String status; // "Delivered", "Preparing", "Cancelled", etc.

  OrderItem({
    required this.foodName,
    required this.restaurant,
    required this.imageUrl,
    required this.dateTime,
    required this.price,
    required this.status,
  });
}

// Sample mock data
final mockOrders = [
  OrderItem(
    foodName: 'Grilled Chicken Salad',
    restaurant: 'Gourmet Bistro',
    imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
    dateTime: DateTime.now().subtract(const Duration(hours: 2)),
    price: 19.99,
    status: 'Delivered',
  ),
  OrderItem(
    foodName: 'Vegan Avocado Toast',
    restaurant: 'Green Eats',
    imageUrl: 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c',
    dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    price: 12.50,
    status: 'Preparing',
  ),
  OrderItem(
    foodName: 'BBQ Beef Burger',
    restaurant: 'Urban Grill',
    imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349',
    dateTime: DateTime.now().subtract(const Duration(days: 3)),
    price: 15.75,
    status: 'Cancelled',
  ),
];

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: mockOrders.isEmpty
          ? Center(
        child: Text(
          "You haven’t ordered anything yet!",
          style: theme.textTheme.titleLarge,
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        itemBuilder: (context, i) => _OrderCard(order: mockOrders[i]),
        separatorBuilder: (context, i) => const SizedBox(height: 18),
        itemCount: mockOrders.length,
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderItem order;
  const _OrderCard({required this.order});

  Color _statusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green[700]!;
      case 'Preparing':
        return Colors.amber[800]!;
      case 'Cancelled':
        return Colors.red[700]!;
      default:
        return Colors.grey[600]!;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Delivered':
        return Icons.check_circle;
      case 'Preparing':
        return Icons.kitchen;
      case 'Cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Food Image
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                order.imageUrl,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[200],
                  width: 72,
                  height: 72,
                  child: const Icon(Icons.fastfood),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Order details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.foodName,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order.restaurant,
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatDateTime(order.dateTime),
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            // Status & Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      _statusIcon(order.status),
                      size: 20,
                      color: _statusColor(order.status),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      order.status,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _statusColor(order.status),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '\$${order.price.toStringAsFixed(2)}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dt.year, dt.month, dt.day);

    if (date == today) {
      return "Today, ${_formatTime(dt)}";
    } else if (date == today.subtract(const Duration(days: 1))) {
      return "Yesterday, ${_formatTime(dt)}";
    } else {
      return "${date.day}/${date.month}/${date.year}, ${_formatTime(dt)}";
    }
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final ampm = dt.hour < 12 ? "AM" : "PM";
    return "$hour:${dt.minute.toString().padLeft(2, '0')} $ampm";
  }
}
