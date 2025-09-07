// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileDtoImpl _$$UserProfileDtoImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileDtoImpl(
      id: json['id'] as String,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      contactNumber: json['contactNumber'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      addressIds:
          (json['addressIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      walletId: json['walletId'] as String?,
      reservationIds:
          (json['reservationIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      paymentMethodIds:
          (json['paymentMethodIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      createdAtIso: json['createdAtIso'] as String?,
      updatedAtIso: json['updatedAtIso'] as String?,
      roleMetadata:
          json['roleMetadata'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
    );

Map<String, dynamic> _$$UserProfileDtoImplToJson(
  _$UserProfileDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'roles': instance.roles,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'contactNumber': instance.contactNumber,
  'avatarUrl': instance.avatarUrl,
  'addressIds': instance.addressIds,
  'walletId': instance.walletId,
  'reservationIds': instance.reservationIds,
  'paymentMethodIds': instance.paymentMethodIds,
  'isEmailVerified': instance.isEmailVerified,
  'isPhoneVerified': instance.isPhoneVerified,
  'createdAtIso': instance.createdAtIso,
  'updatedAtIso': instance.updatedAtIso,
  'roleMetadata': instance.roleMetadata,
};
