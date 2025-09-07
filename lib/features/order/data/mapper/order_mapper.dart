import 'package:restaurant_marketplace/features/discount/data/model/money_model.dart';

import '../../domain/entities/order.dart';
import '../model/order_model.dart';


// --- enum helpers ---
T _enumFromString<T>(Iterable<T> values, String? name, T fallback) {
  if (name == null) return fallback;
  for (final v in values) {
    final n = (v as dynamic).name as String;
    if (n == name) return v;
  }
  return fallback;
}

OrderStatus _status(String s) =>
    _enumFromString(OrderStatus.values, s, OrderStatus.pending);

PaymentMethod _paymentMethod(String s) =>
    _enumFromString(PaymentMethod.values, s, PaymentMethod.other);

FulfillmentType _fulfillmentType(String s) =>
    _enumFromString(FulfillmentType.values, s, FulfillmentType.shipping);

// --- item mapping ---
extension OrderItemModelX on OrderItemModel {
  OrderItem toDomain() => OrderItem(
    id: id,
    sku: sku,
    name: name,
    variant: variant,
    quantity: quantity,
    unitPrice: unitPrice.toDomain(),
    lineSubtotal: lineSubtotal.toDomain(),
    lineDiscount: lineDiscount.toDomain(),
    lineTax: lineTax.toDomain(),
    lineTotal: lineTotal.toDomain(),
    attributes: attributes,
    productId: productId,
  );
}

extension OrderItemX on OrderItem {
  OrderItemModel toModel() => OrderItemModel(
    id: id,
    sku: sku,
    name: name,
    variant: variant,
    quantity: quantity,
    unitPrice: unitPrice.toModel(),
    lineSubtotal: lineSubtotal.toModel(),
    lineDiscount: lineDiscount.toModel(),
    lineTax: lineTax.toModel(),
    lineTotal: lineTotal.toModel(),
    attributes: attributes,
    productId: productId,
  );
}

// --- payment mapping ---
extension PaymentInfoModelX on PaymentInfoModel {
  PaymentInfo toDomain() => PaymentInfo(
    method: _paymentMethod(method),
    provider: provider,
    chargeId: chargeId,
    authorized: authorized,
    captured: captured,
    authorizedAt: authorizedAt,
    capturedAt: capturedAt,
    last4: last4,
  );
}

extension PaymentInfoX on PaymentInfo {
  PaymentInfoModel toModel() => PaymentInfoModel(
    method: method.name,
    provider: provider,
    chargeId: chargeId,
    authorized: authorized,
    captured: captured,
    authorizedAt: authorizedAt,
    capturedAt: capturedAt,
    last4: last4,
  );
}

// --- fulfillment mapping ---
extension FulfillmentInfoModelX on FulfillmentInfoModel {
  FulfillmentInfo toDomain() => FulfillmentInfo(
    type: _fulfillmentType(type),
    carrier: carrier,
    trackingNumber: trackingNumber,
    shippingAddressId: shippingAddressId,
    pickupLocationId: pickupLocationId,
    pickupReadyAt: pickupReadyAt,
    estimatedDeliveryStart: estimatedDeliveryStart,
    estimatedDeliveryEnd: estimatedDeliveryEnd,
    note: note,
  );
}

extension FulfillmentInfoX on FulfillmentInfo {
  FulfillmentInfoModel toModel() => FulfillmentInfoModel(
    type: type.name,
    carrier: carrier,
    trackingNumber: trackingNumber,
    shippingAddressId: shippingAddressId,
    pickupLocationId: pickupLocationId,
    pickupReadyAt: pickupReadyAt,
    estimatedDeliveryStart: estimatedDeliveryStart,
    estimatedDeliveryEnd: estimatedDeliveryEnd,
    note: note,
  );
}

// --- order mapping ---
extension OrderModelX on OrderModel {
  Order toDomain() => Order(
    id: id,
    userId: userId,
    status: _status(status),
    orderNumber: orderNumber,
    externalRef: externalRef,
    items: items.map((e) => e.toDomain()).toList(),
    appliedDiscountCodes: appliedDiscountCodes,
    subtotal: subtotal.toDomain(),
    discountTotal: discountTotal.toDomain(),
    shippingTotal: shippingTotal.toDomain(),
    taxTotal: taxTotal.toDomain(),
    feesTotal: feesTotal.toDomain(),
    grandTotal: grandTotal.toDomain(),
    amountAuthorized: amountAuthorized.toDomain(),
    amountCaptured: amountCaptured.toDomain(),
    amountRefunded: amountRefunded.toDomain(),
    payment: payment?.toDomain(),
    fulfillment: fulfillment?.toDomain(),
    billingAddressId: billingAddressId,
    shippingAddressId: shippingAddressId,
    walletId: walletId,
    createdAt: createdAt,
    updatedAt: updatedAt,
    cancelledAt: cancelledAt,
    completedAt: completedAt,
    metadata: metadata,
    note: note,
  );
}

extension OrderX on Order {
  OrderModel toModel() => OrderModel(
    id: id,
    userId: userId,
    status: status.name,
    orderNumber: orderNumber,
    externalRef: externalRef,
    items: items.map((e) => e.toModel()).toList(),
    appliedDiscountCodes: appliedDiscountCodes,
    subtotal: subtotal.toModel(),
    discountTotal: discountTotal.toModel(),
    shippingTotal: shippingTotal.toModel(),
    taxTotal: taxTotal.toModel(),
    feesTotal: feesTotal.toModel(),
    grandTotal: grandTotal.toModel(),
    amountAuthorized: amountAuthorized.toModel(),
    amountCaptured: amountCaptured.toModel(),
    amountRefunded: amountRefunded.toModel(),
    payment: payment?.toModel(),
    fulfillment: fulfillment?.toModel(),
    billingAddressId: billingAddressId,
    shippingAddressId: shippingAddressId,
    walletId: walletId,
    createdAt: createdAt,
    updatedAt: updatedAt,
    cancelledAt: cancelledAt,
    completedAt: completedAt,
    metadata: metadata,
    note: note,
  );
}
