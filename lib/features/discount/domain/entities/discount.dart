// domain/entities/discount.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../wallet/domain/value_objects/money.dart';

part 'discount.freezed.dart';

/// How the discount value is applied.
enum DiscountValueType { percentage, fixedAmount }

/// Scope of eligibility for items.
enum DiscountScope { entireOrder, specificProducts, specificCategories, shipping }

/// How/when a discount is triggered.
enum DiscountTrigger { code, automatic }

@freezed
class Discount with _$Discount {
  const factory Discount({
    required String id,

    /// Human-readable code if trigger == code. Unique when present.
    String? code,

    /// Classification.
    @Default(DiscountTrigger.code) DiscountTrigger trigger,
    @Default(DiscountValueType.percentage) DiscountValueType valueType,
    /// If percentage: 0–100. If fixedAmount: amount’s numeric part in [amount] with currency.
    @Default(0.0) double percentage,
    /// Fixed value for fixed-amount discounts; currency must be set.
    Money? amount,

    /// Application rules.
    @Default(DiscountScope.entireOrder) DiscountScope scope,
    @Default(<String>[]) List<String> productIds,     // when scope == specificProducts
    @Default(<String>[]) List<String> categoryIds,    // when scope == specificCategories

    /// Order-level constraints.
    Money? minimumSubtotal,        // requires currency
    int? minimumQuantity,          // sum of quantities across matched items

    /// Stacking/usage control.
    @Default(true) bool isActive,
    @Default(false) bool stackable,
    int? maxGlobalRedemptions,     // total allowed across all users
    @Default(0) int globalRedemptionsUsed,
    int? maxPerUser,               // per-user limit

    /// Validity window.
    DateTime? startsAt,
    DateTime? endsAt,

    /// Optional targeting.
    @Default(<String>[]) List<String> eligibleUserIds, // whitelist users
    @Default(false) bool newUsersOnly,

    /// Metadata for analytics/integrations.
    Map<String, String>? metadata,
    String? name,                 // internal name
    String? description,          // UI copy

    /// Audit.
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Discount;
}
