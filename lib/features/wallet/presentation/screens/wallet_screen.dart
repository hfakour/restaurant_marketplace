import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/wallet_local_ds.dart';
import '../../data/repositories/wallet_repository_impl.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../../domain/entities/wallet.dart'; // for Wallet and WalletTransaction
import '../../domain/usecases/add_funds.dart';
import '../../domain/usecases/get_wallet.dart';
import '../../domain/usecases/pay_with_wallet.dart';
import '../../domain/usecases/set_wallet_enabled.dart';
import '../bloc/wallet_bloc.dart';

// Import wallet entities via the package path so that Wallet and
// WalletTransaction types resolve correctly.
import 'package:restaurant_marketplace/features/wallet/domain/entities/wallet.dart';

/// A wallet screen that uses Bloc for state management. It displays the
/// current balance and a history of transactions. Users can top up the
/// balance and attempt payments. If a payment fails due to insufficient
/// funds and autoTopUpDifference is disabled, an error is shown. This
/// screen no longer exposes fiat/crypto toggles — a single currency is
/// assumed per wallet. To integrate with your app, push this screen
/// from the profile instead of using the search tab.
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key, this.walletId = 'wallet_1'});

  final String walletId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // Wire up dependencies manually. In a real app, use get_it or
        // riverpod to provide these globally.
        final localDs = WalletLocalDataSource();
        final repo = WalletRepositoryImpl(localDs);
        return WalletBloc(
          walletId: walletId,
          getWallet: GetWallet(repo),
          addFunds: AddFunds(repo),
          payWithWallet: PayWithWallet(repo),
          setWalletEnabled: SetWalletEnabled(repo),
          repository: repo,
        )..add(const LoadWallet());
      },
      child: const _WalletView(),
    );
  }
}

class _WalletView extends StatelessWidget {
  const _WalletView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: BlocConsumer<WalletBloc, WalletState>(
        listener: (context, state) {
          if (state is WalletError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error.toString())),
            );
          }
        },
        builder: (context, state) {
          return switch (state) {
            WalletInitial() || WalletLoading() => const Center(child: CircularProgressIndicator()),
            WalletError(:final error) => Center(child: Text('Error: $error')),
            WalletLoaded(:final wallet, :final transactions) => _WalletBody(wallet: wallet, transactions: transactions),
            // Fallback
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

class _WalletBody extends StatelessWidget {
  const _WalletBody({required this.wallet, required this.transactions});

  final Wallet wallet;
  final List<WalletTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final balance = wallet.balance;
    return RefreshIndicator(
      onRefresh: () async {
        context.read<WalletBloc>().add(const RefreshWallet());
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Balance card
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primaryContainer, theme.colorScheme.secondaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Balance', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(
                        '${balance.amount.toStringAsFixed(2)} ${balance.currency}',
                        style: theme.textTheme.headlineSmall,
                      ),
                      if (wallet.updatedAt != null)
                        Text(
                          'Updated ${wallet.updatedAt}',
                          style: theme.textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
                // Top up button
                FilledButton.icon(
                  onPressed: () async {
                    // Prompt user for top-up amount; here we simply add 20
                    const double amount = 20.0;
                    context.read<WalletBloc>().add(AddFundsEvent(amount: amount, currency: balance.currency));
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add 20'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Pay button example
          FilledButton.icon(
            onPressed: () async {
              // For demonstration we attempt to pay 100; if insufficient funds and
              // autoTopUpDifference is false, an error will be emitted.
              context.read<WalletBloc>().add(const PayWithWalletEvent(
                price: 100,
                currency: 'USD',
                autoTopUpDifference: true,
                reference: 'demo_purchase',
              ));
            },
            icon: const Icon(Icons.payment),
            label: const Text('Pay \$100'),
          ),
          const SizedBox(height: 16),
          Text('Transactions', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          if (transactions.isEmpty)
            const Text('No transactions yet')
          else
            ...transactions.map((tx) {
              final amount = tx.delta.amount;
              final isNegative = amount < 0;
              final displayAmount = amount.abs().toStringAsFixed(2);
              final color = isNegative ? theme.colorScheme.error : theme.colorScheme.primary;
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                title: Text(
                  tx.createdAt.toLocal().toString(),
                  style: theme.textTheme.bodyMedium,
                ),
                subtitle: Text(
                  // Hide transaction kind here per requirements
                  '',
                ),
                trailing: Text(
                  '${isNegative ? '-' : '+'}\$displayAmount',
                  style: theme.textTheme.titleMedium?.copyWith(color: color),
                ),
                onTap: () {
                  // Navigate to order details if reference is present
                  final refId = tx.reference;
                  if (refId != null) {
                    // TODO: push to order history/details page using refId
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Open details for $refId')),
                    );
                  }
                },
              );
            }).toList(),
        ],
      ),
    );
  }
}
