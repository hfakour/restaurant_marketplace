import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_local_ds.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletLocalDataSource local;
  WalletRepositoryImpl(this.local);

  @override
  Future<Wallet> getById(String walletId) => local.fetch(walletId);

  @override
  Future<Wallet> setEnabled(String walletId, {required bool enabled}) async {
    await local.fetch(walletId);
    return local.setEnabled(enabled);
  }

  @override
  Future<Wallet> addFunds(String walletId, {required double amount, required String currency}) async {
    await local.fetch(walletId);
    return local.addFunds(amount, currency);
  }

  @override
  Future<(Wallet wallet, double topUpAmount, double chargedAmount)> pay(
      String walletId, {
        required double price,
        required String currency,
        bool autoTopUpDifference = true,
        String? reference,
      }) async {
    await local.fetch(walletId);
    return local.pay(
      price: price,
      currency: currency,
      autoTopUpDifference: autoTopUpDifference,
      reference: reference,
    );
  }

  @override
  Future<List<WalletTransaction>> listTransactions(String walletId) async {
    await local.fetch(walletId);
    return local.listTx();
  }
}
