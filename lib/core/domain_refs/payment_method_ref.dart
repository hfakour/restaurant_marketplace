import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method_ref.freezed.dart';

@freezed
class PaymentMethodRef with _$PaymentMethodRef {
  const factory PaymentMethodRef({
    required String paymentMethodId, // e.g., pm_... from PSP
    String? brand,                   // "visa", "mastercard", etc.
    String? last4,                   // safe for display
    @Default(false) bool isDefault,
  }) = _PaymentMethodRef;
}
