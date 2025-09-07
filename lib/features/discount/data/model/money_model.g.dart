// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoneyModel _$MoneyModelFromJson(Map<String, dynamic> json) =>
    MoneyModel((json['amount'] as num).toDouble(), json['currency'] as String);

Map<String, dynamic> _$MoneyModelToJson(MoneyModel instance) =>
    <String, dynamic>{'amount': instance.amount, 'currency': instance.currency};
