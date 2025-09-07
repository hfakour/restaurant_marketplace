import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_dto.freezed.dart';
part 'user_profile_dto.g.dart';

@freezed
class UserProfileDto with _$UserProfileDto {
  const factory UserProfileDto({
    required String id,
    @Default(<String>[]) List<String> roles, // "customer", "restaurantOwner", ...

    required String firstName,
    required String lastName,
    required String email,
    required String contactNumber,

    String? avatarUrl,

    @Default(<String>[]) List<String> addressIds,
    String? walletId,
    @Default(<String>[]) List<String> reservationIds,
    @Default(<String>[]) List<String> paymentMethodIds,

    @Default(false) bool isEmailVerified,
    @Default(false) bool isPhoneVerified,

    String? createdAtIso,
    String? updatedAtIso,

    @Default(<String, dynamic>{}) Map<String, dynamic> roleMetadata,
  }) = _UserProfileDto;

  factory UserProfileDto.fromJson(Map<String, dynamic> json)
  => _$UserProfileDtoFromJson(json);
}
