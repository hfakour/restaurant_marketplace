import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

/// Deprecated: Use [AddFunds] instead. This class forwards to [WalletRepository.addFunds].
/// The [asset] parameter is treated as the currency code.
class TopUpCrypto {
  final WalletRepository _repo;
  TopUpCrypto(this._repo);
  Future<Wallet> call(String walletId, {required double amount, required String asset}) {
    return _repo.addFunds(walletId, amount: amount, currency: asset);
  }
}
