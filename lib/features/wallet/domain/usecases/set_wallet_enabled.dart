import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

/// Use case for enabling or disabling a wallet.
class SetWalletEnabled {
  final WalletRepository _repo;
  SetWalletEnabled(this._repo);

  Future<Wallet> call(
    String walletId, {
    required bool enabled,
  }) {
    return _repo.setEnabled(walletId, enabled: enabled);
  }
}