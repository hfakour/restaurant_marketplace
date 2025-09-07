// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProfileDto _$UserProfileDtoFromJson(Map<String, dynamic> json) {
  return _UserProfileDto.fromJson(json);
}

/// @nodoc
mixin _$UserProfileDto {
  String get id => throw _privateConstructorUsedError;
  List<String> get roles =>
      throw _privateConstructorUsedError; // "customer", "restaurantOwner", ...
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get contactNumber => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  List<String> get addressIds => throw _privateConstructorUsedError;
  String? get walletId => throw _privateConstructorUsedError;
  List<String> get reservationIds => throw _privateConstructorUsedError;
  List<String> get paymentMethodIds => throw _privateConstructorUsedError;
  bool get isEmailVerified => throw _privateConstructorUsedError;
  bool get isPhoneVerified => throw _privateConstructorUsedError;
  String? get createdAtIso => throw _privateConstructorUsedError;
  String? get updatedAtIso => throw _privateConstructorUsedError;
  Map<String, dynamic> get roleMetadata => throw _privateConstructorUsedError;

  /// Serializes this UserProfileDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileDtoCopyWith<UserProfileDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileDtoCopyWith<$Res> {
  factory $UserProfileDtoCopyWith(
    UserProfileDto value,
    $Res Function(UserProfileDto) then,
  ) = _$UserProfileDtoCopyWithImpl<$Res, UserProfileDto>;
  @useResult
  $Res call({
    String id,
    List<String> roles,
    String firstName,
    String lastName,
    String email,
    String contactNumber,
    String? avatarUrl,
    List<String> addressIds,
    String? walletId,
    List<String> reservationIds,
    List<String> paymentMethodIds,
    bool isEmailVerified,
    bool isPhoneVerified,
    String? createdAtIso,
    String? updatedAtIso,
    Map<String, dynamic> roleMetadata,
  });
}

/// @nodoc
class _$UserProfileDtoCopyWithImpl<$Res, $Val extends UserProfileDto>
    implements $UserProfileDtoCopyWith<$Res> {
  _$UserProfileDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roles = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? contactNumber = null,
    Object? avatarUrl = freezed,
    Object? addressIds = null,
    Object? walletId = freezed,
    Object? reservationIds = null,
    Object? paymentMethodIds = null,
    Object? isEmailVerified = null,
    Object? isPhoneVerified = null,
    Object? createdAtIso = freezed,
    Object? updatedAtIso = freezed,
    Object? roleMetadata = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            roles: null == roles
                ? _value.roles
                : roles // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            contactNumber: null == contactNumber
                ? _value.contactNumber
                : contactNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            addressIds: null == addressIds
                ? _value.addressIds
                : addressIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            walletId: freezed == walletId
                ? _value.walletId
                : walletId // ignore: cast_nullable_to_non_nullable
                      as String?,
            reservationIds: null == reservationIds
                ? _value.reservationIds
                : reservationIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            paymentMethodIds: null == paymentMethodIds
                ? _value.paymentMethodIds
                : paymentMethodIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isEmailVerified: null == isEmailVerified
                ? _value.isEmailVerified
                : isEmailVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPhoneVerified: null == isPhoneVerified
                ? _value.isPhoneVerified
                : isPhoneVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAtIso: freezed == createdAtIso
                ? _value.createdAtIso
                : createdAtIso // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAtIso: freezed == updatedAtIso
                ? _value.updatedAtIso
                : updatedAtIso // ignore: cast_nullable_to_non_nullable
                      as String?,
            roleMetadata: null == roleMetadata
                ? _value.roleMetadata
                : roleMetadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileDtoImplCopyWith<$Res>
    implements $UserProfileDtoCopyWith<$Res> {
  factory _$$UserProfileDtoImplCopyWith(
    _$UserProfileDtoImpl value,
    $Res Function(_$UserProfileDtoImpl) then,
  ) = __$$UserProfileDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    List<String> roles,
    String firstName,
    String lastName,
    String email,
    String contactNumber,
    String? avatarUrl,
    List<String> addressIds,
    String? walletId,
    List<String> reservationIds,
    List<String> paymentMethodIds,
    bool isEmailVerified,
    bool isPhoneVerified,
    String? createdAtIso,
    String? updatedAtIso,
    Map<String, dynamic> roleMetadata,
  });
}

/// @nodoc
class __$$UserProfileDtoImplCopyWithImpl<$Res>
    extends _$UserProfileDtoCopyWithImpl<$Res, _$UserProfileDtoImpl>
    implements _$$UserProfileDtoImplCopyWith<$Res> {
  __$$UserProfileDtoImplCopyWithImpl(
    _$UserProfileDtoImpl _value,
    $Res Function(_$UserProfileDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roles = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? contactNumber = null,
    Object? avatarUrl = freezed,
    Object? addressIds = null,
    Object? walletId = freezed,
    Object? reservationIds = null,
    Object? paymentMethodIds = null,
    Object? isEmailVerified = null,
    Object? isPhoneVerified = null,
    Object? createdAtIso = freezed,
    Object? updatedAtIso = freezed,
    Object? roleMetadata = null,
  }) {
    return _then(
      _$UserProfileDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        roles: null == roles
            ? _value._roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        contactNumber: null == contactNumber
            ? _value.contactNumber
            : contactNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        addressIds: null == addressIds
            ? _value._addressIds
            : addressIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        walletId: freezed == walletId
            ? _value.walletId
            : walletId // ignore: cast_nullable_to_non_nullable
                  as String?,
        reservationIds: null == reservationIds
            ? _value._reservationIds
            : reservationIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        paymentMethodIds: null == paymentMethodIds
            ? _value._paymentMethodIds
            : paymentMethodIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isEmailVerified: null == isEmailVerified
            ? _value.isEmailVerified
            : isEmailVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPhoneVerified: null == isPhoneVerified
            ? _value.isPhoneVerified
            : isPhoneVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAtIso: freezed == createdAtIso
            ? _value.createdAtIso
            : createdAtIso // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAtIso: freezed == updatedAtIso
            ? _value.updatedAtIso
            : updatedAtIso // ignore: cast_nullable_to_non_nullable
                  as String?,
        roleMetadata: null == roleMetadata
            ? _value._roleMetadata
            : roleMetadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileDtoImpl implements _UserProfileDto {
  const _$UserProfileDtoImpl({
    required this.id,
    final List<String> roles = const <String>[],
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    this.avatarUrl,
    final List<String> addressIds = const <String>[],
    this.walletId,
    final List<String> reservationIds = const <String>[],
    final List<String> paymentMethodIds = const <String>[],
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.createdAtIso,
    this.updatedAtIso,
    final Map<String, dynamic> roleMetadata = const <String, dynamic>{},
  }) : _roles = roles,
       _addressIds = addressIds,
       _reservationIds = reservationIds,
       _paymentMethodIds = paymentMethodIds,
       _roleMetadata = roleMetadata;

  factory _$UserProfileDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileDtoImplFromJson(json);

  @override
  final String id;
  final List<String> _roles;
  @override
  @JsonKey()
  List<String> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  // "customer", "restaurantOwner", ...
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String contactNumber;
  @override
  final String? avatarUrl;
  final List<String> _addressIds;
  @override
  @JsonKey()
  List<String> get addressIds {
    if (_addressIds is EqualUnmodifiableListView) return _addressIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addressIds);
  }

  @override
  final String? walletId;
  final List<String> _reservationIds;
  @override
  @JsonKey()
  List<String> get reservationIds {
    if (_reservationIds is EqualUnmodifiableListView) return _reservationIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reservationIds);
  }

  final List<String> _paymentMethodIds;
  @override
  @JsonKey()
  List<String> get paymentMethodIds {
    if (_paymentMethodIds is EqualUnmodifiableListView)
      return _paymentMethodIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethodIds);
  }

  @override
  @JsonKey()
  final bool isEmailVerified;
  @override
  @JsonKey()
  final bool isPhoneVerified;
  @override
  final String? createdAtIso;
  @override
  final String? updatedAtIso;
  final Map<String, dynamic> _roleMetadata;
  @override
  @JsonKey()
  Map<String, dynamic> get roleMetadata {
    if (_roleMetadata is EqualUnmodifiableMapView) return _roleMetadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_roleMetadata);
  }

  @override
  String toString() {
    return 'UserProfileDto(id: $id, roles: $roles, firstName: $firstName, lastName: $lastName, email: $email, contactNumber: $contactNumber, avatarUrl: $avatarUrl, addressIds: $addressIds, walletId: $walletId, reservationIds: $reservationIds, paymentMethodIds: $paymentMethodIds, isEmailVerified: $isEmailVerified, isPhoneVerified: $isPhoneVerified, createdAtIso: $createdAtIso, updatedAtIso: $updatedAtIso, roleMetadata: $roleMetadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            const DeepCollectionEquality().equals(
              other._addressIds,
              _addressIds,
            ) &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            const DeepCollectionEquality().equals(
              other._reservationIds,
              _reservationIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._paymentMethodIds,
              _paymentMethodIds,
            ) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.isPhoneVerified, isPhoneVerified) ||
                other.isPhoneVerified == isPhoneVerified) &&
            (identical(other.createdAtIso, createdAtIso) ||
                other.createdAtIso == createdAtIso) &&
            (identical(other.updatedAtIso, updatedAtIso) ||
                other.updatedAtIso == updatedAtIso) &&
            const DeepCollectionEquality().equals(
              other._roleMetadata,
              _roleMetadata,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    const DeepCollectionEquality().hash(_roles),
    firstName,
    lastName,
    email,
    contactNumber,
    avatarUrl,
    const DeepCollectionEquality().hash(_addressIds),
    walletId,
    const DeepCollectionEquality().hash(_reservationIds),
    const DeepCollectionEquality().hash(_paymentMethodIds),
    isEmailVerified,
    isPhoneVerified,
    createdAtIso,
    updatedAtIso,
    const DeepCollectionEquality().hash(_roleMetadata),
  );

  /// Create a copy of UserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileDtoImplCopyWith<_$UserProfileDtoImpl> get copyWith =>
      __$$UserProfileDtoImplCopyWithImpl<_$UserProfileDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileDtoImplToJson(this);
  }
}

abstract class _UserProfileDto implements UserProfileDto {
  const factory _UserProfileDto({
    required final String id,
    final List<String> roles,
    required final String firstName,
    required final String lastName,
    required final String email,
    required final String contactNumber,
    final String? avatarUrl,
    final List<String> addressIds,
    final String? walletId,
    final List<String> reservationIds,
    final List<String> paymentMethodIds,
    final bool isEmailVerified,
    final bool isPhoneVerified,
    final String? createdAtIso,
    final String? updatedAtIso,
    final Map<String, dynamic> roleMetadata,
  }) = _$UserProfileDtoImpl;

  factory _UserProfileDto.fromJson(Map<String, dynamic> json) =
      _$UserProfileDtoImpl.fromJson;

  @override
  String get id;
  @override
  List<String> get roles; // "customer", "restaurantOwner", ...
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get contactNumber;
  @override
  String? get avatarUrl;
  @override
  List<String> get addressIds;
  @override
  String? get walletId;
  @override
  List<String> get reservationIds;
  @override
  List<String> get paymentMethodIds;
  @override
  bool get isEmailVerified;
  @override
  bool get isPhoneVerified;
  @override
  String? get createdAtIso;
  @override
  String? get updatedAtIso;
  @override
  Map<String, dynamic> get roleMetadata;

  /// Create a copy of UserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileDtoImplCopyWith<_$UserProfileDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
