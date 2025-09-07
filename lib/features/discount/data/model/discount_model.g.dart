// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountModel _$DiscountModelFromJson(
  Map<String, dynamic> json,
) => DiscountModel(
  id: json['id'] as String,
  code: json['code'] as String?,
  trigger: json['trigger'] as String,
  valueType: json['valueType'] as String,
  percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
  amount: json['amount'] == null
      ? null
      : MoneyModel.fromJson(json['amount'] as Map<String, dynamic>),
  scope: json['scope'] as String,
  productIds:
      (json['productIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  categoryIds:
      (json['categoryIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  minimumSubtotal: json['minimumSubtotal'] == null
      ? null
      : MoneyModel.fromJson(json['minimumSubtotal'] as Map<String, dynamic>),
  minimumQuantity: (json['minimumQuantity'] as num?)?.toInt(),
  isActive: json['isActive'] as bool? ?? true,
  stackable: json['stackable'] as bool? ?? false,
  maxGlobalRedemptions: (json['maxGlobalRedemptions'] as num?)?.toInt(),
  globalRedemptionsUsed: (json['globalRedemptionsUsed'] as num?)?.toInt() ?? 0,
  maxPerUser: (json['maxPerUser'] as num?)?.toInt(),
  startsAt: json['startsAt'] == null
      ? null
      : DateTime.parse(json['startsAt'] as String),
  endsAt: json['endsAt'] == null
      ? null
      : DateTime.parse(json['endsAt'] as String),
  eligibleUserIds:
      (json['eligibleUserIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  newUsersOnly: json['newUsersOnly'] as bool? ?? false,
  metadata: (json['metadata'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  name: json['name'] as String?,
  description: json['description'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$DiscountModelToJson(DiscountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'trigger': instance.trigger,
      'valueType': instance.valueType,
      'percentage': instance.percentage,
      'amount': instance.amount?.toJson(),
      'scope': instance.scope,
      'productIds': instance.productIds,
      'categoryIds': instance.categoryIds,
      'minimumSubtotal': instance.minimumSubtotal?.toJson(),
      'minimumQuantity': instance.minimumQuantity,
      'isActive': instance.isActive,
      'stackable': instance.stackable,
      'maxGlobalRedemptions': instance.maxGlobalRedemptions,
      'globalRedemptionsUsed': instance.globalRedemptionsUsed,
      'maxPerUser': instance.maxPerUser,
      'startsAt': instance.startsAt?.toIso8601String(),
      'endsAt': instance.endsAt?.toIso8601String(),
      'eligibleUserIds': instance.eligibleUserIds,
      'newUsersOnly': instance.newUsersOnly,
      'metadata': instance.metadata,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
