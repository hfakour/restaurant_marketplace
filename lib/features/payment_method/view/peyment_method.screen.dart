import 'package:flutter/material.dart';

// ----- MOCK MODELS -----
class PaymentCard {
  final String id;
  final String brand; // 'Visa', 'MasterCard', etc.
  final String last4;
  final bool isDefault;

  PaymentCard({
    required this.id,
    required this.brand,
    required this.last4,
    this.isDefault = false,
  });
}

// ----- MOCK DATA -----
final mockWalletBalance = 53.75;
final mockCards = [
  PaymentCard(id: '1', brand: 'Visa', last4: '1234', isDefault: true),
  PaymentCard(id: '2', brand: 'MasterCard', last4: '5678', isDefault: false),
];

// ----- COLORS -----
const Color kAmber = Colors.amber;
const Color kBrown = Color(0xFF8D6748);

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        children: [
          // ---- WALLET ----
          _WalletCard(balance: mockWalletBalance),
          const SizedBox(height: 34),

          // ---- CARDS ----
          Text("Cards", style: theme.textTheme.titleMedium?.copyWith(color: kBrown)),
          const SizedBox(height: 14),
          ...mockCards.map((c) => _PaymentCardItem(card: c)).toList(),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: kAmber,
              side: const BorderSide(color: kAmber),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              // TODO: Implement add card logic or navigation
            },
            icon: const Icon(Icons.add_card_rounded),
            label: const Text("Add new card"),
          ),
        ],
      ),
    );
  }
}

// ----- WALLET CARD -----
class _WalletCard extends StatelessWidget {
  final double balance;
  const _WalletCard({required this.balance});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kAmber,
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 22),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "Wallet" label
                  Text(
                    "Wallet",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: kBrown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Balance and amount in one row
                  Row(
                    children: [
                      Text('Balance',
                          style: theme.textTheme.bodySmall?.copyWith(color: kBrown)),
                      const Spacer(),
                      Text(
                        '\$${balance.toStringAsFixed(2)}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: kBrown,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAmber,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  elevation: 0,
                ),
                onPressed: () {
                  // TODO: Implement top-up action
                },
                icon: const Icon(Icons.add, size: 20),
                label: const Text("Top Up"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----- PAYMENT CARD ITEM -----
class _PaymentCardItem extends StatelessWidget {
  final PaymentCard card;
  const _PaymentCardItem({required this.card});

  String _brandAsset(String brand) {
    // Use your own assets or just fallback to icons
    switch (brand.toLowerCase()) {
      case 'visa':
        return 'assets/cards/visa.png';
      case 'mastercard':
        return 'assets/cards/mastercard.png';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Arrange actions on the trailing side
    final List<Widget> trailingActions = [
      // Default (Visa) shows check, others show radio
      if (card.isDefault && card.brand.toLowerCase() == 'visa')
        Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Icon(Icons.check_circle, color: kAmber, size: 24),
        )
      else if (!card.isDefault)
        Padding(
          padding: const EdgeInsets.only(right: 6),
          child: IconButton(
            tooltip: "Set as default",
            icon: Icon(Icons.radio_button_unchecked, color: kBrown, size: 24),
            onPressed: () {
              // TODO: set as default
            },
          ),
        ),
      IconButton(
        tooltip: "Remove",
        icon: Icon(Icons.delete_outline, color: Colors.red[800]),
        onPressed: () {
          // TODO: remove card logic
        },
      ),
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: card.brand == "Visa" || card.brand == "MasterCard"
            ? Image.asset(
          _brandAsset(card.brand),
          width: 42,
          height: 32,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Icon(
            card.brand == "Visa" ? Icons.credit_card : Icons.payment,
            color: kBrown,
            size: 32,
          ),
        )
            : Icon(Icons.credit_card, size: 32, color: kBrown),
        title: Text(
          "${card.brand} •••• ${card.last4}",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: kBrown,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: trailingActions,
        ),
        onTap: () {
          // TODO: select/set as default
        },
      ),
    );
  }
}
