// domain/entities/order_ref.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_ref.freezed.dart';

enum OrderStatusSnapshot {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  completed,
  cancelled,
  refunded,
  partiallyRefunded,
  failed,
}

/// Lightweight reference for embedding inside other aggregates (e.g. WalletTransaction note, Reservation, etc.)
@freezed
class OrderRef with _$OrderRef {
  const factory OrderRef({
    required String orderId,

    /// Minimal UI snapshot fields to avoid depending on Money in light refs.
    double? grandTotalSnapshot,
    String? currencyCode,

    OrderStatusSnapshot? statusSnapshot,
    DateTime? placedAt,

    /// Optional human-readable code for quick linking.
    String? orderNumber,
  }) = _OrderRef;
}
