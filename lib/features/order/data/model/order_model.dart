import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../discount/data/model/money_model.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderItemModel {
  final String id;
  final String sku;
  final String name;
  final String? variant;
  final int quantity;
  final MoneyModel unitPrice;
  final MoneyModel lineSubtotal;
  final MoneyModel lineDiscount;
  final MoneyModel lineTax;
  final MoneyModel lineTotal;
  final Map<String, String>? attributes;
  final String? productId;

  const OrderItemModel({
    required this.id,
    required this.sku,
    required this.name,
    this.variant,
    this.quantity = 1,
    required this.unitPrice,
    required this.lineSubtotal,
    required this.lineDiscount,
    required this.lineTax,
    required this.lineTotal,
    this.attributes,
    this.productId,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}

@JsonSerializable()
class PaymentInfoModel {
  final String method; // PaymentMethod.name
  final String? provider;
  final String? chargeId;
  final bool authorized;
  final bool captured;
  final DateTime? authorizedAt;
  final DateTime? capturedAt;
  final String? last4;

  const PaymentInfoModel({
    required this.method,
    this.provider,
    this.chargeId,
    this.authorized = false,
    this.captured = false,
    this.authorizedAt,
    this.capturedAt,
    this.last4,
  });

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentInfoModelToJson(this);
}

@JsonSerializable()
class FulfillmentInfoModel {
  final String type; // FulfillmentType.name
  final String? carrier;
  final String? trackingNumber;
  final String? shippingAddressId;
  final String? pickupLocationId;
  final DateTime? pickupReadyAt;
  final DateTime? estimatedDeliveryStart;
  final DateTime? estimatedDeliveryEnd;
  final String? note;

  const FulfillmentInfoModel({
    required this.type,
    this.carrier,
    this.trackingNumber,
    this.shippingAddressId,
    this.pickupLocationId,
    this.pickupReadyAt,
    this.estimatedDeliveryStart,
    this.estimatedDeliveryEnd,
    this.note,
  });

  factory FulfillmentInfoModel.fromJson(Map<String, dynamic> json) =>
      _$FulfillmentInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$FulfillmentInfoModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderModel {
  final String id;
  final String userId;

  final String status; // OrderStatus.name

  final String? orderNumber;
  final String? externalRef;

  final List<OrderItemModel> items;
  final List<String> appliedDiscountCodes;

  final MoneyModel subtotal;
  final MoneyModel discountTotal;
  final MoneyModel shippingTotal;
  final MoneyModel taxTotal;
  final MoneyModel feesTotal;
  final MoneyModel grandTotal;

  final MoneyModel amountAuthorized;
  final MoneyModel amountCaptured;
  final MoneyModel amountRefunded;

  final PaymentInfoModel? payment;
  final FulfillmentInfoModel? fulfillment;

  final String? billingAddressId;
  final String? shippingAddressId;
  final String? walletId;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? cancelledAt;
  final DateTime? completedAt;

  final Map<String, String>? metadata;
  final String? note;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    this.orderNumber,
    this.externalRef,
    this.items = const [],
    this.appliedDiscountCodes = const [],
    required this.subtotal,
    required this.discountTotal,
    required this.shippingTotal,
    required this.taxTotal,
    required this.feesTotal,
    required this.grandTotal,
    required this.amountAuthorized,
    required this.amountCaptured,
    required this.amountRefunded,
    this.payment,
    this.fulfillment,
    this.billingAddressId,
    this.shippingAddressId,
    this.walletId,
    this.createdAt,
    this.updatedAt,
    this.cancelledAt,
    this.completedAt,
    this.metadata,
    this.note,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
