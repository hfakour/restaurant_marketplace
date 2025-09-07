// domain/entities/discount_ref.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'discount_ref.freezed.dart';

@freezed
class DiscountRef with _$DiscountRef {
  const factory DiscountRef({
    required String discountId,

    /// Minimal snapshot fields for checkout UI.
    String? codeSnapshot,
    double? percentageSnapshot,
    double? fixedAmountSnapshot,
    String? currencyCode,
    DateTime? snapshotAt,

    /// Whether it was stackable at the time it was added.
    @Default(false) bool wasStackable,
  }) = _DiscountRef;
}
