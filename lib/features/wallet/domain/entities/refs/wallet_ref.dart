import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_ref.freezed.dart';

@freezed
class WalletRef with _$WalletRef {
  const factory WalletRef({
    required String walletId,
    @Default(false) bool isActive,
    double? balanceSnapshot, // UI-only; not authoritative
    String? currencyCode,
    DateTime? snapshotAt,
  }) = _WalletRef;
}
