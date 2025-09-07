import 'package:restaurant_marketplace/features/discount/data/model/money_model.dart';

import '../../domain/entities/discount.dart';
import '../model/discount_model.dart';


extension _Enums on Object {
  // Helper to serialize/deserialize enums as strings without coupling to index.
}

DiscountTrigger _triggerFromString(String s) =>
    DiscountTrigger.values.firstWhere((e) => e.name == s,
        orElse: () => DiscountTrigger.code);

DiscountValueType _valueTypeFromString(String s) =>
    DiscountValueType.values.firstWhere((e) => e.name == s,
        orElse: () => DiscountValueType.percentage);

DiscountScope _scopeFromString(String s) =>
    DiscountScope.values.firstWhere((e) => e.name == s,
        orElse: () => DiscountScope.entireOrder);

extension DiscountMapper on DiscountModel {
  Discount toDomain() {
    return Discount(
      id: id,
      code: code,
      trigger: _triggerFromString(trigger),
      valueType: _valueTypeFromString(valueType),
      percentage: percentage,
      amount: amount?.toDomain(),
      scope: _scopeFromString(scope),
      productIds: productIds,
      categoryIds: categoryIds,
      minimumSubtotal: minimumSubtotal?.toDomain(),
      minimumQuantity: minimumQuantity,
      isActive: isActive,
      stackable: stackable,
      maxGlobalRedemptions: maxGlobalRedemptions,
      globalRedemptionsUsed: globalRedemptionsUsed,
      maxPerUser: maxPerUser,
      startsAt: startsAt,
      endsAt: endsAt,
      eligibleUserIds: eligibleUserIds,
      newUsersOnly: newUsersOnly,
      metadata: metadata,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension DiscountDomainToModel on Discount {
  DiscountModel toModel() {
    return DiscountModel(
      id: id,
      code: code,
      trigger: trigger.name,
      valueType: valueType.name,
      percentage: percentage,
      amount: amount?.toModel(),
      scope: scope.name,
      productIds: productIds,
      categoryIds: categoryIds,
      minimumSubtotal: minimumSubtotal?.toModel(),
      minimumQuantity: minimumQuantity,
      isActive: isActive,
      stackable: stackable,
      maxGlobalRedemptions: maxGlobalRedemptions,
      globalRedemptionsUsed: globalRedemptionsUsed,
      maxPerUser: maxPerUser,
      startsAt: startsAt,
      endsAt: endsAt,
      eligibleUserIds: eligibleUserIds,
      newUsersOnly: newUsersOnly,
      metadata: metadata,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
