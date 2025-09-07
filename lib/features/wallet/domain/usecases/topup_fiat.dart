import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

/// Deprecated: Use [AddFunds] instead. This class forwards to [WalletRepository.addFunds].
class TopUpFiat {
  final WalletRepository _repo;
  TopUpFiat(this._repo);
  Future<Wallet> call(String walletId, {required double amount, required String currency}) {
    return _repo.addFunds(walletId, amount: amount, currency: currency);
  }
}
