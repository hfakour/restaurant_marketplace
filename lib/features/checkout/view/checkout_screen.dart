import 'package:flutter/material.dart';

// --- COLOR PALETTE ---
const bgColor = Color(0xFFF8F4EF);
const cardBg = Colors.white;
const charcoal = Color(0xFF232325);
const subtleGray = Color(0xFFEEEEEE);
const gold = Color(0xFFD4AF37);

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
  double get _discount => _couponApplied ? 5.00 : 0.00;
  double get _total => mockSubtotal + mockDeliveryFee - _discount;

  final _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _applyCoupon() {
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
      backgroundColor: bgColor,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: charcoal,
        foregroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
          onPressed: () => Navigator.of(context).maybePop(),
          tooltip: 'Back',
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontFamily: 'Georgia',
            fontSize: 22,
            letterSpacing: -1,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 24, 18, 36),
        children: [
          // --- Delivery Address ---
          _SectionLabel(label: "Delivery Address"),
          Card(
            color: cardBg,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            shadowColor: Colors.black12,
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.location_on_rounded, color: gold, size: 29),
              title: Text(
                mockDeliveryAddress,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: charcoal,
                  fontFamily: 'Georgia',
                  fontSize: 16.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: gold,
                  side: const BorderSide(color: gold),
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // TODO: Implement address picker
                },
                child: const Text("Change", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Georgia')),
              ),
            ),
          ),
          const SizedBox(height: 23),

          // --- Payment Method ---
          _SectionLabel(label: "Payment Method"),
          Card(
            color: cardBg,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            shadowColor: Colors.black12,
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.credit_card_rounded, color: gold, size: 27),
              title: Text(
                mockPaymentMethod,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: charcoal,
                  fontFamily: 'Georgia',
                  fontSize: 16.2,
                ),
              ),
              trailing: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: gold,
                  side: const BorderSide(color: gold),
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // TODO: Implement payment picker
                },
                child: const Text("Change", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Georgia')),
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
          const SizedBox(height: 21),

          // --- Order Summary ---
          _SectionLabel(label: "Order Summary"),
          ...mockCartSummary.map((item) => _CheckoutItemTile(
            name: item["name"] as String,
            imageUrl: item["image"] as String,
            quantity: item["quantity"] as int,
            price: item["price"] as double,
          )),
          const Divider(height: 38, thickness: 1, color: subtleGray),

          // --- Cost breakdown ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal', style: theme.textTheme.bodyLarge?.copyWith(fontFamily: 'Georgia', color: charcoal)),
                Text('\$${mockSubtotal.toStringAsFixed(2)}',
                    style: theme.textTheme.bodyLarge?.copyWith(fontFamily: 'Georgia', fontWeight: FontWeight.bold, color: charcoal)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery Fee', style: theme.textTheme.bodyLarge?.copyWith(fontFamily: 'Georgia', color: charcoal)),
                Text('\$${mockDeliveryFee.toStringAsFixed(2)}',
                    style: theme.textTheme.bodyLarge?.copyWith(fontFamily: 'Georgia', fontWeight: FontWeight.bold, color: charcoal)),
              ],
            ),
          ),
          if (_couponApplied)
            Padding(
              padding: const EdgeInsets.only(top: 7.0, bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.local_offer, color: Colors.green, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        'Coupon "${_coupon.toUpperCase()}"',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '-\$${_discount.toStringAsFixed(2)}',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Georgia',
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w900, fontFamily: 'Georgia', color: charcoal)),
                Text('\$${_total.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w900, color: gold, fontFamily: 'Georgia', fontSize: 20)),
              ],
            ),
          ),
          const SizedBox(height: 22),

          // --- Confirm Order Button ---
          SizedBox(
            width: double.infinity,
            height: 53,
            child: FilledButton.icon(
              icon: const Icon(Icons.lock_outline_rounded, color: charcoal),
              label: Text(
                'Confirm & Pay • \$${_total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: charcoal, fontFamily: 'Georgia', letterSpacing: -0.3),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: gold,
                foregroundColor: charcoal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Georgia'),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 11),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    title: const Text("Order Placed", style: TextStyle(fontWeight: FontWeight.bold, color: charcoal, fontFamily: 'Georgia')),
                    content: const Text("Thank you for your order! Your food is on its way.", style: TextStyle(fontFamily: 'Georgia')),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontFamily: 'Georgia')),
                      ),
                    ],
                  ),
                );
              },
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
          color: charcoal,
          fontWeight: FontWeight.bold,
          fontFamily: 'Georgia',
          fontSize: 16.5,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: const Icon(Icons.local_offer, color: Colors.green, size: 24),
        title: Text(
          'Coupon "$coupon" Applied!',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.green[800],
            fontWeight: FontWeight.bold,
            fontFamily: 'Georgia',
          ),
        ),
        trailing: TextButton(
          onPressed: onRemove,
          child: const Text("Remove", style: TextStyle(color: Colors.red, fontFamily: 'Georgia', fontWeight: FontWeight.bold)),
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
              labelStyle: const TextStyle(fontFamily: 'Georgia', fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: gold,
            foregroundColor: charcoal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Georgia'),
            elevation: 0,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrl,
            width: 54,
            height: 54,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: subtleGray,
              width: 54,
              height: 54,
              child: const Icon(Icons.fastfood, color: charcoal),
            ),
          ),
        ),
        title: Text(
          name,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: 'Georgia',
            color: charcoal,
            fontSize: 15.7,
          ),
        ),
        subtitle: Text(
          'x$quantity',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontFamily: 'Georgia',
            color: charcoal.withOpacity(.7),
          ),
        ),
        trailing: Text(
          '\$${(price * quantity).toStringAsFixed(2)}',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
            fontFamily: 'Georgia',
            color: charcoal,
            fontSize: 16,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
