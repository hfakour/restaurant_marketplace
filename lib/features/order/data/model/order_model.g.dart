// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      id: json['id'] as String,
      sku: json['sku'] as String,
      name: json['name'] as String,
      variant: json['variant'] as String?,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      unitPrice: MoneyModel.fromJson(json['unitPrice'] as Map<String, dynamic>),
      lineSubtotal: MoneyModel.fromJson(
        json['lineSubtotal'] as Map<String, dynamic>,
      ),
      lineDiscount: MoneyModel.fromJson(
        json['lineDiscount'] as Map<String, dynamic>,
      ),
      lineTax: MoneyModel.fromJson(json['lineTax'] as Map<String, dynamic>),
      lineTotal: MoneyModel.fromJson(json['lineTotal'] as Map<String, dynamic>),
      attributes: (json['attributes'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      productId: json['productId'] as String?,
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'variant': instance.variant,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice.toJson(),
      'lineSubtotal': instance.lineSubtotal.toJson(),
      'lineDiscount': instance.lineDiscount.toJson(),
      'lineTax': instance.lineTax.toJson(),
      'lineTotal': instance.lineTotal.toJson(),
      'attributes': instance.attributes,
      'productId': instance.productId,
    };

PaymentInfoModel _$PaymentInfoModelFromJson(Map<String, dynamic> json) =>
    PaymentInfoModel(
      method: json['method'] as String,
      provider: json['provider'] as String?,
      chargeId: json['chargeId'] as String?,
      authorized: json['authorized'] as bool? ?? false,
      captured: json['captured'] as bool? ?? false,
      authorizedAt: json['authorizedAt'] == null
          ? null
          : DateTime.parse(json['authorizedAt'] as String),
      capturedAt: json['capturedAt'] == null
          ? null
          : DateTime.parse(json['capturedAt'] as String),
      last4: json['last4'] as String?,
    );

Map<String, dynamic> _$PaymentInfoModelToJson(PaymentInfoModel instance) =>
    <String, dynamic>{
      'method': instance.method,
      'provider': instance.provider,
      'chargeId': instance.chargeId,
      'authorized': instance.authorized,
      'captured': instance.captured,
      'authorizedAt': instance.authorizedAt?.toIso8601String(),
      'capturedAt': instance.capturedAt?.toIso8601String(),
      'last4': instance.last4,
    };

FulfillmentInfoModel _$FulfillmentInfoModelFromJson(
  Map<String, dynamic> json,
) => FulfillmentInfoModel(
  type: json['type'] as String,
  carrier: json['carrier'] as String?,
  trackingNumber: json['trackingNumber'] as String?,
  shippingAddressId: json['shippingAddressId'] as String?,
  pickupLocationId: json['pickupLocationId'] as String?,
  pickupReadyAt: json['pickupReadyAt'] == null
      ? null
      : DateTime.parse(json['pickupReadyAt'] as String),
  estimatedDeliveryStart: json['estimatedDeliveryStart'] == null
      ? null
      : DateTime.parse(json['estimatedDeliveryStart'] as String),
  estimatedDeliveryEnd: json['estimatedDeliveryEnd'] == null
      ? null
      : DateTime.parse(json['estimatedDeliveryEnd'] as String),
  note: json['note'] as String?,
);

Map<String, dynamic> _$FulfillmentInfoModelToJson(
  FulfillmentInfoModel instance,
) => <String, dynamic>{
  'type': instance.type,
  'carrier': instance.carrier,
  'trackingNumber': instance.trackingNumber,
  'shippingAddressId': instance.shippingAddressId,
  'pickupLocationId': instance.pickupLocationId,
  'pickupReadyAt': instance.pickupReadyAt?.toIso8601String(),
  'estimatedDeliveryStart': instance.estimatedDeliveryStart?.toIso8601String(),
  'estimatedDeliveryEnd': instance.estimatedDeliveryEnd?.toIso8601String(),
  'note': instance.note,
};

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: json['id'] as String,
  userId: json['userId'] as String,
  status: json['status'] as String,
  orderNumber: json['orderNumber'] as String?,
  externalRef: json['externalRef'] as String?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  appliedDiscountCodes:
      (json['appliedDiscountCodes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  subtotal: MoneyModel.fromJson(json['subtotal'] as Map<String, dynamic>),
  discountTotal: MoneyModel.fromJson(
    json['discountTotal'] as Map<String, dynamic>,
  ),
  shippingTotal: MoneyModel.fromJson(
    json['shippingTotal'] as Map<String, dynamic>,
  ),
  taxTotal: MoneyModel.fromJson(json['taxTotal'] as Map<String, dynamic>),
  feesTotal: MoneyModel.fromJson(json['feesTotal'] as Map<String, dynamic>),
  grandTotal: MoneyModel.fromJson(json['grandTotal'] as Map<String, dynamic>),
  amountAuthorized: MoneyModel.fromJson(
    json['amountAuthorized'] as Map<String, dynamic>,
  ),
  amountCaptured: MoneyModel.fromJson(
    json['amountCaptured'] as Map<String, dynamic>,
  ),
  amountRefunded: MoneyModel.fromJson(
    json['amountRefunded'] as Map<String, dynamic>,
  ),
  payment: json['payment'] == null
      ? null
      : PaymentInfoModel.fromJson(json['payment'] as Map<String, dynamic>),
  fulfillment: json['fulfillment'] == null
      ? null
      : FulfillmentInfoModel.fromJson(
          json['fulfillment'] as Map<String, dynamic>,
        ),
  billingAddressId: json['billingAddressId'] as String?,
  shippingAddressId: json['shippingAddressId'] as String?,
  walletId: json['walletId'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  cancelledAt: json['cancelledAt'] == null
      ? null
      : DateTime.parse(json['cancelledAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  metadata: (json['metadata'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  note: json['note'] as String?,
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'status': instance.status,
      'orderNumber': instance.orderNumber,
      'externalRef': instance.externalRef,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'appliedDiscountCodes': instance.appliedDiscountCodes,
      'subtotal': instance.subtotal.toJson(),
      'discountTotal': instance.discountTotal.toJson(),
      'shippingTotal': instance.shippingTotal.toJson(),
      'taxTotal': instance.taxTotal.toJson(),
      'feesTotal': instance.feesTotal.toJson(),
      'grandTotal': instance.grandTotal.toJson(),
      'amountAuthorized': instance.amountAuthorized.toJson(),
      'amountCaptured': instance.amountCaptured.toJson(),
      'amountRefunded': instance.amountRefunded.toJson(),
      'payment': instance.payment?.toJson(),
      'fulfillment': instance.fulfillment?.toJson(),
      'billingAddressId': instance.billingAddressId,
      'shippingAddressId': instance.shippingAddressId,
      'walletId': instance.walletId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'metadata': instance.metadata,
      'note': instance.note,
    };
