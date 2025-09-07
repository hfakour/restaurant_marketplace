import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

/// Deprecated: Crypto mode has been removed. Use [SetWalletEnabled]
/// instead to enable or disable the entire wallet.
class ToggleCryptoMode {
  final WalletRepository _repo;
  ToggleCryptoMode(this._repo);
  Future<Wallet> call(String walletId, {required bool enabled}) {
    // Map crypto mode toggling to enabling/disabling the wallet.
    return _repo.setEnabled(walletId, enabled: enabled);
  }
}
