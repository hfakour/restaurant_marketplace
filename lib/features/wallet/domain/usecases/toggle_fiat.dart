import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

/// Deprecated: Fiat and crypto modes have been removed. Use [SetWalletEnabled]
/// instead to enable or disable the entire wallet.
class ToggleFiatMode {
  final WalletRepository _repo;
  ToggleFiatMode(this._repo);
  Future<Wallet> call(String walletId, {required bool enabled}) {
    // In the new wallet model, enabling/disabling fiat mode maps to enabling
    // or disabling the whole wallet.
    return _repo.setEnabled(walletId, enabled: enabled);
  }
}
