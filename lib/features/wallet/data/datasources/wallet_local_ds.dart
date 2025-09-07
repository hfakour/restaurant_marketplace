import 'dart:math';
import '../../domain/entities/wallet.dart';
import '../../domain/value_objects/money.dart';

class WalletLocalDataSource {
  WalletLocalDataSource() {
    // Seed a demo wallet
    _wallet = Wallet(
      id: 'wallet_1',
      userId: 'user_001',
      enabled: true,
      balance: const Money(50.0, 'USD'),
      updatedAt: DateTime.now().toUtc(),
    );
    _tx = <WalletTransaction>[];
  }

  late Wallet _wallet;
  late List<WalletTransaction> _tx;

  // ── READ ────────────────────────────────────────────────────────────────────
  Future<Wallet> fetch(String walletId) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    if (_wallet.id != walletId) {
      throw StateError('Wallet not found: $walletId');
    }
    return _wallet;
  }

  Future<List<WalletTransaction>> listTx() async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return List<WalletTransaction>.unmodifiable(_tx.reversed);
  }

  // ── ENABLE/DISABLE ─────────────────────────────────────────────────────────
  /// Enable or disable the wallet. When disabled, payments will throw an error.
  Future<Wallet> setEnabled(bool enabled) async {
    await Future<void>.delayed(const Duration(milliseconds: 60));
    _wallet = _wallet.copyWith(
      enabled: enabled,
      updatedAt: DateTime.now().toUtc(),
    );
    return _wallet;
  }

  // ── TOP-UPS ────────────────────────────────────────────────────────────────
  Future<Wallet> addFunds(double amount, String currency) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));

    // If currency changes, swap it (assume user switched currency)
    if (_wallet.balance.currency != currency) {
      _wallet = _wallet.copyWith(
        balance: Money(_wallet.balance.amount, currency),
      );
    }

    final double newAmount = (_wallet.balance.amount + amount).clamp(0.0, double.infinity);

    _wallet = _wallet.copyWith(
      balance: Money(newAmount, _wallet.balance.currency),
      updatedAt: DateTime.now().toUtc(),
    );

    _tx.add(
      WalletTransaction(
        id: 'tx_${Random().nextInt(1 << 30)}',
        walletId: _wallet.id,
        createdAt: DateTime.now().toUtc(),
        kind: 'topup',
        delta: Money(amount, _wallet.balance.currency),
        note: 'Top-up',
      ),
    );

    return _wallet;
  }

  // ── PAYMENTS ───────────────────────────────────────────────────────────────
  /// Pay using the wallet. If balance < price and [autoTopUpDifference] is true,
  /// top up the difference first, then charge the full price. Returns
  /// (wallet, topUpAmount, chargedAmount). Throws if the wallet is disabled.
  Future<(Wallet wallet, double topUp, double charged)> pay({
    required double price,
    required String currency,
    required bool autoTopUpDifference,
    String? reference,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (!_wallet.enabled) throw StateError('Wallet disabled');

    // Align currency
    if (_wallet.balance.currency != currency) {
      _wallet = _wallet.copyWith(
        balance: Money(_wallet.balance.amount, currency),
      );
    }

    final double current = _wallet.balance.amount;

    if (current >= price) {
      final double newAmount = (current - price).clamp(0.0, double.infinity);

      _wallet = _wallet.copyWith(
        balance: Money(newAmount, _wallet.balance.currency),
        updatedAt: DateTime.now().toUtc(),
      );

      _tx.add(
        WalletTransaction(
          id: 'tx_${Random().nextInt(1 << 30)}',
          walletId: _wallet.id,
          createdAt: DateTime.now().toUtc(),
          kind: 'payment',
          delta: Money(-price, currency),
          reference: reference,
          note: 'Payment',
        ),
      );

      return (_wallet, 0.0, price);
    }

    final double diff = price - current;
    if (!autoTopUpDifference) {
      throw StateError('Insufficient funds and auto top-up disabled');
    }

    // Top up the gap first
    await addFunds(diff, currency);

    // Then charge full price
    final double afterTopUp = _wallet.balance.amount;
    final double newAmount = (afterTopUp - price).clamp(0.0, double.infinity);

    _wallet = _wallet.copyWith(
      balance: Money(newAmount, _wallet.balance.currency),
      updatedAt: DateTime.now().toUtc(),
    );

    _tx.add(
      WalletTransaction(
        id: 'tx_${Random().nextInt(1 << 30)}',
        walletId: _wallet.id,
        createdAt: DateTime.now().toUtc(),
        kind: 'payment',
        delta: Money(-price, currency),
        reference: reference,
        note: 'Payment (auto top-up)',
      ),
    );

    return (_wallet, diff, price);
  }
}
