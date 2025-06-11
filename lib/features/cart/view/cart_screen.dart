import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CartScreen()));

const kBgColor = Color(0xFFF8F4EF);
const kCardBg = Colors.white;
const kCharcoal = Color(0xFF232325); // Modern dark accent
const kSubtleGray = Color(0xFFEEEEEE);

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

final mockCart = [
  CartItem(
    name: 'Grilled Chicken Salad',
    restaurant: 'Gourmet Bistro',
    imageUrl: 'https://www.starbaal.com/uploads/posts/dfdf5d.jpg?m=thumb&w=800&h=600&q=high',
    price: 19.99,
    quantity: 2,
    tags: ['Gluten-Free', 'Medium Spicy', 'Low Carb', 'High Protein', 'Vegan', 'Dairy Free'],
  ),
  CartItem(
    name: 'Vegan Avocado Toast',
    restaurant: 'Green Eats',
    imageUrl: 'https://www.starbaal.com/uploads/posts/dfdf5d.jpg?m=thumb&w=800&h=600&q=high',
    price: 12.50,
    quantity: 1,
    tags: ['Vegan', 'Organic'],
  ),
];

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = mockCart;
    final total = cartItems.fold<double>(0.0, (t, item) => t + item.price * item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: -0.2,
          ),
        ),
        backgroundColor: kCharcoal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: kBgColor,
      body: Column(
        children: [
          // Address Card (fixed, top)
          const _AddressCard(
            name: 'Home',
            details: '123 Flutter Street, Springfield, USA',
          ),
          // Main Cart Card (fills remaining space, scrollable if needed)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: kCardBg,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cart Items
                    Expanded(
                      child: ListView.separated(
                        itemCount: cartItems.length,
                        separatorBuilder: (_, __) =>
                        const Divider(height: 24, thickness: 0.65, color: Color(0x1F232325)),
                        itemBuilder: (context, i) => _CartItemRow(item: cartItems[i]),
                      ),
                    ),
                    // Checkout Button
                    Padding(
                      padding: const EdgeInsets.only(top: 18, bottom: 8),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[700],
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Proceed to Checkout • \$${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- ADDRESS CARD ---
class _AddressCard extends StatelessWidget {
  final String name;
  final String details;

  const _AddressCard({
    required this.name,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kBgColor,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: kCharcoal,
              fontSize: 18,
              letterSpacing: -0.1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            details,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: kCharcoal.withOpacity(0.5),
              fontWeight: FontWeight.w500,
              fontSize: 14.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// --- CART ITEM ROW ---
class _CartItemRow extends StatelessWidget {
  final CartItem item;
  const _CartItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // LEFT: image
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.network(
            item.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: kBgColor,
              width: 60,
              height: 60,
              child: Icon(Icons.fastfood, color: kCharcoal.withOpacity(0.5), size: 28),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Center: name, restaurant, tags
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: kCharcoal,
                  fontSize: 16.5,
                  letterSpacing: -0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                item.restaurant,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: kCharcoal.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                  fontSize: 13.5,
                  letterSpacing: -0.1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 7),
              if (item.tags.isNotEmpty)
                _TagsRow(tags: item.tags),
            ],
          ),
        ),
        // RIGHT: quantity controls
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _QuantityButton(
                icon: Icons.remove,
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Text(
                  '${item.quantity}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: kCharcoal,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
              ),
              _QuantityButton(
                icon: Icons.add,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- TAGS ROW ---
class _TagsRow extends StatelessWidget {
  final List<String> tags;
  static const int maxTags = 4;
  const _TagsRow({required this.tags});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showTags = tags.length > maxTags ? tags.sublist(0, maxTags) : tags;
    final remaining = tags.length - maxTags;

    return Wrap(
      spacing: 7,
      children: [
        ...showTags.map(
              (tag) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: kSubtleGray,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              tag,
              style: theme.textTheme.bodySmall?.copyWith(
                color: kCharcoal,
                fontWeight: FontWeight.w600,
                fontSize: 13,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ),
        if (remaining > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "+$remaining",
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.amber[900],
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
      ],
    );
  }
}

// --- QUANTITY BUTTON ---
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
            backgroundColor: kBgColor
        ),
        onPressed: onPressed,
        child: Icon(icon, size: 18, color: Colors.amber[900]),
      ),
    );
  }
}
