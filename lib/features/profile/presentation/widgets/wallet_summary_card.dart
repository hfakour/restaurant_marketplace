import 'package:flutter/material.dart';
import 'package:restaurant_marketplace/core/domain_refs/wallet_ref.dart';

import '../../../wallet/domain/value_objects/money.dart';

class WalletSummaryCard extends StatelessWidget {
  const WalletSummaryCard({
    super.key,
    required this.walletRef,
    this.onLink,
    this.onUnlink,
  });

  final WalletRef? walletRef;
  final VoidCallback? onLink;
  final VoidCallback? onUnlink;

  @override
  Widget build(BuildContext context) {
    if (walletRef == null) {
      return _EmptyWallet(onLink: onLink);
    }
    final amount = (walletRef!.balanceSnapshot ?? 0.0);
    final currency = walletRef!.currencyCode ?? 'USD';
    final money = Money(amount, currency).format();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.tertiaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            child: const Icon(Icons.account_balance_wallet),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Wallet', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(
                  money,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (walletRef!.snapshotAt != null)
                  Text(
                    'Updated ${walletRef!.snapshotAt}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: onUnlink,
            icon: const Icon(Icons.link_off),
            label: const Text('Unlink'),
          ),
        ],
      ),
    );
  }
}

class _EmptyWallet extends StatelessWidget {
  const _EmptyWallet({this.onLink});
  final VoidCallback? onLink;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          const Icon(Icons.account_balance_wallet_outlined),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'No wallet connected',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          FilledButton.icon(
            onPressed: onLink,
            icon: const Icon(Icons.link),
            label: const Text('Link'),
          ),
        ],
      ),
    );
  }
}
