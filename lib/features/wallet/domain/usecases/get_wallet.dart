import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

class GetWallet {
  final WalletRepository _repo;
  GetWallet(this._repo);
  Future<Wallet> call(String walletId) => _repo.getById(walletId);
}
