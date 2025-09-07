import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/money.dart';

part 'wallet.freezed.dart';

/// Represents a user wallet that holds a single fiat balance. Crypto support has
/// been removed for simplicity. Each wallet tracks an ID, the owning user ID,
/// whether the wallet is enabled, the current balance, and when it was last
/// updated. All monetary values are represented using the [Money] value object
/// (amount + currency). In future you could extend this to support multiple
/// currencies by replacing [balance] with a map of currencies.
@freezed
class Wallet with _$Wallet {
  const factory Wallet({
    required String id,
    required String userId,

    /// Whether the wallet is active. Disabled wallets cannot be used for payments.
    @Default(true) bool enabled,

    /// Current balance of the wallet in a single currency.
    @Default(Money(0.0, 'USD')) Money balance,

    /// Optional last updated time for UI display.
    DateTime? updatedAt,
  }) = _Wallet;
}

/// A record of a change to the wallet balance. Each transaction stores the
/// delta applied to the balance as a [Money] value, a kind (e.g. 'topup',
/// 'payment', 'refund'), and optional references for matching with order IDs.
@freezed
class WalletTransaction with _$WalletTransaction {
  const factory WalletTransaction({
    required String id,
    required String walletId,
    required DateTime createdAt,

    /// The kind of transaction: 'topup', 'payment', 'refund', etc.
    required String kind,

    /// The change in wallet balance for this transaction. Positive values
    /// represent funds added to the wallet, negative values represent
    /// deductions (e.g. purchases).
    required Money delta,

    /// Optional order or payment reference used to correlate with order history.
    String? reference,
    String? note,
  }) = _WalletTransaction;
}
