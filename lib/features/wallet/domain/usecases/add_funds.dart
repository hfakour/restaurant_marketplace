import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

/// Use case for adding funds to a wallet.
///
/// Given a wallet ID and an amount with currency, this use case delegates
/// to the [WalletRepository] to perform the operation. If the wallet holds a
/// different currency, its currency will be updated to match.
class AddFunds {
  final WalletRepository _repo;
  AddFunds(this._repo);

  Future<Wallet> call(
    String walletId, {
    required double amount,
    required String currency,
  }) {
    return _repo.addFunds(walletId, amount: amount, currency: currency);
  }
}