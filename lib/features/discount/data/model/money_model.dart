import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../wallet/domain/value_objects/money.dart';

part 'money_model.g.dart';

@JsonSerializable()
class MoneyModel {
  final double amount;
  final String currency;

  const MoneyModel(this.amount, this.currency);

  factory MoneyModel.fromJson(Map<String, dynamic> json) =>
      _$MoneyModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoneyModelToJson(this);
}

extension MoneyModelX on MoneyModel {
  Money toDomain() => Money(amount, currency);
}

extension MoneyX on Money {
  MoneyModel toModel() => MoneyModel(amount, currency);
}
