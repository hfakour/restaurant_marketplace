import 'package:flutter/material.dart';

// TODO: Replace with your model/provider imports when ready
class CartItem {
  final String name;
  final String restaurant;
  final String imageUrl;
  final double price;
  final int quantity;
  final List<String> tags;

  CartItem({
    required this.name,
    required this.restaurant,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    this.tags = const [],
  });
}

// Mock cart data
final mockCart = [
  CartItem(
    name: 'Grilled Chicken Salad',
    restaurant: 'Gourmet Bistro',
    imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
    price: 19.99,
    quantity: 2,
    tags: ['Gluten-Free', 'Medium Spicy'],
  ),
  CartItem(
    name: 'Vegan Avocado Toast',
    restaurant: 'Green Eats',
    imageUrl: 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c',
    price: 12.50,
    quantity: 1,
    tags: ['Vegan', 'Organic'],
  ),
];

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartItems = mockCart; // Replace with your Riverpod provider in real app
    final total = cartItems.fold<double>(0.0, (t, item) => t + item.price * item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text(
          'Your cart is empty!',
          style: theme.textTheme.titleLarge,
        ),
      )
          : ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // Cart items
          ...cartItems.map((item) => _CartItemCard(item: item)).toList(),
          const SizedBox(height: 24),
          // Total section
          _CartTotalSection(total: total),
          const SizedBox(height: 16),
          // Checkout button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[700],
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            onPressed: () {
              // TODO: Implement checkout logic
            },
            child: Text(
              'Proceed to Checkout • \$${total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem item;
  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                item.imageUrl,
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
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.restaurant,
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: item.tags
                        .map((tag) => Chip(
                      label: Text(tag, style: theme.textTheme.bodySmall),
                      backgroundColor: Colors.amber[50],
                    ))
                        .toList(),
                  ),
                ],
              ),
            ),
            // Price & Quantity controls
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _QuantityButton(
                      icon: Icons.remove,
                      onPressed: () {
                        // TODO: Decrease quantity via provider
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('${item.quantity}', style: theme.textTheme.bodyLarge),
                    ),
                    _QuantityButton(
                      icon: Icons.add,
                      onPressed: () {
                        // TODO: Increase quantity via provider
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const _QuantityButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: const BorderSide(color: Colors.amber),
        ),
        onPressed: onPressed,
        child: Icon(icon, size: 18, color: Colors.amber[900]),
      ),
    );
  }
}

class _CartTotalSection extends StatelessWidget {
  final double total;
  const _CartTotalSection({required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            Text('\$${total.toStringAsFixed(2)}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold, color: Colors.green[700])),
          ],
        ),
      ),
    );
  }
}
