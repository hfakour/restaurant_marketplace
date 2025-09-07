// domain/entities/address.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';

enum AddressLabel { home, work, other }

@freezed
class Address with _$Address {
  const factory Address({
    required String id,
    required String userId,

    required String street,
    required String city,
    String? state,
    required String postalCode,
    required String country,

    double? latitude,
    double? longitude,

    AddressLabel? label,
    @Default(false) bool isDefault,

    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Address;
}
