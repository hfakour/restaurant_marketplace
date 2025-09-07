import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/discount.dart';
import 'money_model.dart';

part 'discount_model.g.dart';

/// Data/persistence representation (DTO). Keep it flat JSON-friendly.
@JsonSerializable(explicitToJson: true)
class DiscountModel {
  final String id;
  final String? code;

  final String trigger;      // DiscountTrigger
  final String valueType;    // DiscountValueType
  final double percentage;
  final MoneyModel? amount;  // fixed amount

  final String scope;        // DiscountScope
  final List<String> productIds;
  final List<String> categoryIds;

  final MoneyModel? minimumSubtotal;
  final int? minimumQuantity;

  final bool isActive;
  final bool stackable;
  final int? maxGlobalRedemptions;
  final int globalRedemptionsUsed;
  final int? maxPerUser;

  final DateTime? startsAt;
  final DateTime? endsAt;

  final List<String> eligibleUserIds;
  final bool newUsersOnly;

  final Map<String, String>? metadata;
  final String? name;
  final String? description;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const DiscountModel({
    required this.id,
    this.code,
    required this.trigger,
    required this.valueType,
    this.percentage = 0.0,
    this.amount,
    required this.scope,
    this.productIds = const [],
    this.categoryIds = const [],
    this.minimumSubtotal,
    this.minimumQuantity,
    this.isActive = true,
    this.stackable = false,
    this.maxGlobalRedemptions,
    this.globalRedemptionsUsed = 0,
    this.maxPerUser,
    this.startsAt,
    this.endsAt,
    this.eligibleUserIds = const [],
    this.newUsersOnly = false,
    this.metadata,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountModelToJson(this);
}
