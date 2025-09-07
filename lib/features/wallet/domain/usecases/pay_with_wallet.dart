import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

class PayWithWallet {
  final WalletRepository _repo;
  PayWithWallet(this._repo);

  /// Returns a tuple of (updated wallet, amount automatically topped up, amount charged).
  Future<(Wallet, double, double)> call(
    String walletId, {
    required double price,
    required String currency,
    bool autoTopUpDifference = true,
    String? reference,
  }) {
    return _repo.pay(
      walletId,
      price: price,
      currency: currency,
      autoTopUpDifference: autoTopUpDifference,
      reference: reference,
    );
  }
}
