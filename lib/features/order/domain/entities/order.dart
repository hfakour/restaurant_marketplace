// domain/entities/order.dart
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../wallet/domain/value_objects/money.dart';

part 'order.freezed.dart';

/// Order lifecycle states.
enum OrderStatus {
  pending,        // created but not confirmed/paid yet
  confirmed,      // payment authorized / order accepted
  processing,     // being prepared/packed
  shipped,        // handed to carrier
  delivered,      // received by customer
  completed,      // post-delivery window closed; archived
  cancelled,      // cancelled by user/system
  refunded,       // fully refunded
  partiallyRefunded,
  failed,         // payment/fulfillment failure
}

/// Payment method/type used to settle the order.
enum PaymentMethod {
  card,
  wallet,
  cashOnDelivery,
  bankTransfer,
  paypal,
  applePay,
  googlePay,
  other,
}

/// High-level fulfillment mode for the order.
enum FulfillmentType { shipping, pickup, digital, service }

/// Line item within an order.
@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String id,
    required String sku,                // inventory SKU or service code
    required String name,               // snapshot for audit/UI
    String? variant,                    // e.g. color/size
    @Default(1) int quantity,
    @Default(Money(0.0, 'USD')) Money unitPrice,   // price per unit at purchase
    @Default(Money(0.0, 'USD')) Money lineSubtotal, // unitPrice * quantity before discounts/tax
    @Default(Money(0.0, 'USD')) Money lineDiscount, // total discount applied to this line
    @Default(Money(0.0, 'USD')) Money lineTax,      // tax portion for this line
    @Default(Money(0.0, 'USD')) Money lineTotal,    // final for this line
    Map<String, String>? attributes,   // arbitrary attributes snapshot
    String? productId,                 // optional back-link
  }) = _OrderItem;
}

/// Summary of payment on the order.
@freezed
class PaymentInfo with _$PaymentInfo {
  const factory PaymentInfo({
    required PaymentMethod method,
    String? provider,                  // e.g. 'Stripe'
    String? chargeId,                  // PSP charge/payment ID
    @Default(false) bool authorized,
    @Default(false) bool captured,
    DateTime? authorizedAt,
    DateTime? capturedAt,
    String? last4,                     // masked PAN tail if card
  }) = _PaymentInfo;
}

/// Shipping / pickup snapshot (not a full Address to avoid deep coupling).
@freezed
class FulfillmentInfo with _$FulfillmentInfo {
  const factory FulfillmentInfo({
    required FulfillmentType type,
    // For shipping:
    String? carrier,
    String? trackingNumber,
    String? shippingAddressId, // points to Address by ID
    // For pickup:
    String? pickupLocationId,
    DateTime? pickupReadyAt,
    // Common:
    DateTime? estimatedDeliveryStart,
    DateTime? estimatedDeliveryEnd,
    String? note,
  }) = _FulfillmentInfo;
}

/// Order aggregate.
@freezed
class Order with _$Order {
  const factory Order({
    required String id,
    required String userId,

    @Default(OrderStatus.pending) OrderStatus status,

    /// Optional external references for integrations.
    String? orderNumber,           // human-facing order code
    String? externalRef,           // ERP/OMS reference

    /// Cart snapshot.
    @Default(<OrderItem>[]) List<OrderItem> items,

    /// Discount/coupon codes actually applied at checkout.
    @Default(<String>[]) List<String> appliedDiscountCodes,

    /// Totals snapshot (authoritative at the time of purchase).
    @Default(Money(0.0, 'USD')) Money subtotal,        // sum of line subtotals
    @Default(Money(0.0, 'USD')) Money discountTotal,   // sum of all discounts
    @Default(Money(0.0, 'USD')) Money shippingTotal,
    @Default(Money(0.0, 'USD')) Money taxTotal,
    @Default(Money(0.0, 'USD')) Money feesTotal,       // service/handling fees
    @Default(Money(0.0, 'USD')) Money grandTotal,      // payable: subtotal - discount + shipping + tax + fees

    /// Amounts paid/refunded.
    @Default(Money(0.0, 'USD')) Money amountAuthorized,
    @Default(Money(0.0, 'USD')) Money amountCaptured,
    @Default(Money(0.0, 'USD')) Money amountRefunded,

    /// Payment & fulfillment snapshots.
    PaymentInfo? payment,
    FulfillmentInfo? fulfillment,

    /// Optional address references (billing/shipping) by ID.
    String? billingAddressId,
    String? shippingAddressId,

    /// Optional wallet used (by ID) when method == wallet.
    String? walletId,

    /// Audit fields.
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? cancelledAt,
    DateTime? completedAt,

    /// Free-form metadata for integrations/analytics.
    Map<String, String>? metadata,
    String? note,
  }) = _Order;
}
