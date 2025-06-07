import 'package:flutter/material.dart';

// Mocked data models (replace with your real providers/models)
final mockDeliveryAddress = "123 Market Street, Downtown, Warsaw";
final mockPaymentMethod = "Visa •••• 4242";
final mockCartSummary = [
  {
    "name": "Grilled Chicken Salad",
    "quantity": 2,
    "price": 19.99,
    "image":
    "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
  },
  {
    "name": "Vegan Avocado Toast",
    "quantity": 1,
    "price": 12.50,
    "image":
    "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
  }
];
final double mockSubtotal = 19.99 * 2 + 12.50;
final double mockDeliveryFee = 2.99;

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _coupon = '';
  bool _couponApplied = false;
  double get _discount =>
      _couponApplied ? 5.00 : 0.00; // Example: $5 discount when coupon applied
  double get _total => mockSubtotal + mockDeliveryFee - _discount;

  final _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _applyCoupon() {
    // Simple fake validation: any non-empty code applies a $5 discount
    if (_couponController.text.trim().isNotEmpty) {
      setState(() {
        _coupon = _couponController.text.trim();
        _couponApplied = true;
      });
      FocusScope.of(context).unfocus();
    }
  }

  void _removeCoupon() {
    setState(() {
      _coupon = '';
      _couponApplied = false;
      _couponController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // Section: Delivery Address
          _SectionLabel(label: "Delivery Address"),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Icon(Icons.location_on, color: Colors.amber[800]),
              title: Text(
                mockDeliveryAddress,
                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: TextButton(
                onPressed: () {
                  // TODO: Implement address picker
                },
                child: Text("Change", style: TextStyle(color: Colors.amber[800])),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Section: Payment Method
          _SectionLabel(label: "Payment Method"),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Icon(Icons.credit_card, color: Colors.amber[800]),
              title: Text(
                mockPaymentMethod,
                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: TextButton(
                onPressed: () {
                  // TODO: Implement payment method picker
                },
                child: Text("Change", style: TextStyle(color: Colors.amber[800])),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // --- Coupon Section ---
          _SectionLabel(label: "Coupon"),
          _CouponField(
            controller: _couponController,
            applied: _couponApplied,
            coupon: _coupon,
            onApply: _applyCoupon,
            onRemove: _removeCoupon,
          ),
          const SizedBox(height: 20),

          // --- Order Summary ---
          _SectionLabel(label: "Order Summary"),
          ...mockCartSummary.map((item) => _CheckoutItemTile(
            name: item["name"] as String,
            imageUrl: item["image"] as String,
            quantity: item["quantity"] as int,
            price: item["price"] as double,
          )),
          const Divider(height: 32, thickness: 1),
          // Cost breakdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal', style: theme.textTheme.bodyLarge),
              Text('\$${mockSubtotal.toStringAsFixed(2)}',
                  style: theme.textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery Fee', style: theme.textTheme.bodyLarge),
              Text('\$${mockDeliveryFee.toStringAsFixed(2)}',
                  style: theme.textTheme.bodyLarge),
            ],
          ),
          if (_couponApplied)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_offer, color: Colors.green[700], size: 20),
                      const SizedBox(width: 6),
                      Text(
                        'Coupon "${_coupon.toUpperCase()}"',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '-\$${_discount.toStringAsFixed(2)}',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text('\$${_total.toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold, color: Colors.green[700])),
            ],
          ),
          const SizedBox(height: 32),
          // Confirm Order button
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
              // TODO: Implement order confirmation logic
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Order Placed"),
                  content: const Text(
                      "Thank you for your order! Your food is on its way."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'Confirm & Pay • \$${_total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 2, left: 2),
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

class _CouponField extends StatelessWidget {
  final TextEditingController controller;
  final bool applied;
  final String coupon;
  final VoidCallback onApply;
  final VoidCallback onRemove;

  const _CouponField({
    required this.controller,
    required this.applied,
    required this.coupon,
    required this.onApply,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return applied
        ? Card(
      color: Colors.green[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.local_offer, color: Colors.green[700]),
        title: Text(
          'Coupon "$coupon" Applied!',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.green[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: TextButton(
          onPressed: onRemove,
          child: const Text("Remove", style: TextStyle(color: Colors.red)),
        ),
      ),
    )
        : Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: "Enter coupon code",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber[700],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          ),
          onPressed: onApply,
          child: const Text("Apply", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class _CheckoutItemTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int quantity;
  final double price;
  const _CheckoutItemTile({
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl,
          width: 54,
          height: 54,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: Colors.grey[200],
            width: 54,
            height: 54,
            child: const Icon(Icons.fastfood),
          ),
        ),
      ),
      title: Text(
        name,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('x$quantity', style: theme.textTheme.bodyMedium),
      trailing: Text(
        '\$${(price * quantity).toStringAsFixed(2)}',
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
