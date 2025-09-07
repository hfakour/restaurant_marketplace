import '../entities/wallet.dart';

abstract class WalletRepository {
  /// Fetch the wallet for the given ID.
  Future<Wallet> getById(String walletId);

  /// Enable or disable the wallet. Disabled wallets cannot be used for payments.
  Future<Wallet> setEnabled(String walletId, {required bool enabled});

  /// Add funds to the wallet. The [currency] argument specifies which currency
  /// the amount is denominated in. If the wallet currently holds a different
  /// currency, its currency will be updated to match.
  Future<Wallet> addFunds(String walletId, {required double amount, required String currency});

  /// Pay using the wallet. If the balance is insufficient and [autoTopUpDifference]
  /// is true, the repository will automatically top up the difference, then
  /// charge the full price. The returned tuple contains the updated wallet,
  /// the amount automatically topped up (0 if none), and the amount charged.
  Future<(Wallet wallet, double topUpAmount, double chargedAmount)> pay(
      String walletId, {
        required double price,
        required String currency,
        bool autoTopUpDifference = true,
        String? reference,
      });

  /// Return an ordered list of the wallet’s transactions, most recent first.
  Future<List<WalletTransaction>> listTransactions(String walletId);
}
