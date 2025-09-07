// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserProfile {
  String get id => throw _privateConstructorUsedError;
  Set<UserRole> get roles => throw _privateConstructorUsedError; // Identity
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get contactNumber => throw _privateConstructorUsedError; // Media
  String? get avatarUrl =>
      throw _privateConstructorUsedError; // Cross-feature refs
  List<AddressRef> get addressRefs => throw _privateConstructorUsedError;
  WalletRef? get walletRef => throw _privateConstructorUsedError;
  List<ReservationRef> get reservationRefs =>
      throw _privateConstructorUsedError;
  List<PaymentMethodRef> get paymentMethodRefs =>
      throw _privateConstructorUsedError; // Verification flags
  bool get isEmailVerified => throw _privateConstructorUsedError;
  bool get isPhoneVerified => throw _privateConstructorUsedError; // Auditing
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Role-specific extra data (safe by design)
  Map<String, dynamic> get roleMetadata => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    String id,
    Set<UserRole> roles,
    String firstName,
    String lastName,
    String email,
    String contactNumber,
    String? avatarUrl,
    List<AddressRef> addressRefs,
    WalletRef? walletRef,
    List<ReservationRef> reservationRefs,
    List<PaymentMethodRef> paymentMethodRefs,
    bool isEmailVerified,
    bool isPhoneVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic> roleMetadata,
  });

  $WalletRefCopyWith<$Res>? get walletRef;
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
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
    Object? addressRefs = null,
    Object? walletRef = freezed,
    Object? reservationRefs = null,
    Object? paymentMethodRefs = null,
    Object? isEmailVerified = null,
    Object? isPhoneVerified = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
                      as Set<UserRole>,
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
            addressRefs: null == addressRefs
                ? _value.addressRefs
                : addressRefs // ignore: cast_nullable_to_non_nullable
                      as List<AddressRef>,
            walletRef: freezed == walletRef
                ? _value.walletRef
                : walletRef // ignore: cast_nullable_to_non_nullable
                      as WalletRef?,
            reservationRefs: null == reservationRefs
                ? _value.reservationRefs
                : reservationRefs // ignore: cast_nullable_to_non_nullable
                      as List<ReservationRef>,
            paymentMethodRefs: null == paymentMethodRefs
                ? _value.paymentMethodRefs
                : paymentMethodRefs // ignore: cast_nullable_to_non_nullable
                      as List<PaymentMethodRef>,
            isEmailVerified: null == isEmailVerified
                ? _value.isEmailVerified
                : isEmailVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPhoneVerified: null == isPhoneVerified
                ? _value.isPhoneVerified
                : isPhoneVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            roleMetadata: null == roleMetadata
                ? _value.roleMetadata
                : roleMetadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletRefCopyWith<$Res>? get walletRef {
    if (_value.walletRef == null) {
      return null;
    }

    return $WalletRefCopyWith<$Res>(_value.walletRef!, (value) {
      return _then(_value.copyWith(walletRef: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    Set<UserRole> roles,
    String firstName,
    String lastName,
    String email,
    String contactNumber,
    String? avatarUrl,
    List<AddressRef> addressRefs,
    WalletRef? walletRef,
    List<ReservationRef> reservationRefs,
    List<PaymentMethodRef> paymentMethodRefs,
    bool isEmailVerified,
    bool isPhoneVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic> roleMetadata,
  });

  @override
  $WalletRefCopyWith<$Res>? get walletRef;
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
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
    Object? addressRefs = null,
    Object? walletRef = freezed,
    Object? reservationRefs = null,
    Object? paymentMethodRefs = null,
    Object? isEmailVerified = null,
    Object? isPhoneVerified = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? roleMetadata = null,
  }) {
    return _then(
      _$UserProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        roles: null == roles
            ? _value._roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as Set<UserRole>,
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
        addressRefs: null == addressRefs
            ? _value._addressRefs
            : addressRefs // ignore: cast_nullable_to_non_nullable
                  as List<AddressRef>,
        walletRef: freezed == walletRef
            ? _value.walletRef
            : walletRef // ignore: cast_nullable_to_non_nullable
                  as WalletRef?,
        reservationRefs: null == reservationRefs
            ? _value._reservationRefs
            : reservationRefs // ignore: cast_nullable_to_non_nullable
                  as List<ReservationRef>,
        paymentMethodRefs: null == paymentMethodRefs
            ? _value._paymentMethodRefs
            : paymentMethodRefs // ignore: cast_nullable_to_non_nullable
                  as List<PaymentMethodRef>,
        isEmailVerified: null == isEmailVerified
            ? _value.isEmailVerified
            : isEmailVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPhoneVerified: null == isPhoneVerified
            ? _value.isPhoneVerified
            : isPhoneVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        roleMetadata: null == roleMetadata
            ? _value._roleMetadata
            : roleMetadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    required this.id,
    final Set<UserRole> roles = const <UserRole>{},
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    this.avatarUrl,
    final List<AddressRef> addressRefs = const <AddressRef>[],
    this.walletRef,
    final List<ReservationRef> reservationRefs = const <ReservationRef>[],
    final List<PaymentMethodRef> paymentMethodRefs = const <PaymentMethodRef>[],
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.createdAt,
    this.updatedAt,
    final Map<String, dynamic> roleMetadata = const <String, dynamic>{},
  }) : _roles = roles,
       _addressRefs = addressRefs,
       _reservationRefs = reservationRefs,
       _paymentMethodRefs = paymentMethodRefs,
       _roleMetadata = roleMetadata;

  @override
  final String id;
  final Set<UserRole> _roles;
  @override
  @JsonKey()
  Set<UserRole> get roles {
    if (_roles is EqualUnmodifiableSetView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_roles);
  }

  // Identity
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String contactNumber;
  // Media
  @override
  final String? avatarUrl;
  // Cross-feature refs
  final List<AddressRef> _addressRefs;
  // Cross-feature refs
  @override
  @JsonKey()
  List<AddressRef> get addressRefs {
    if (_addressRefs is EqualUnmodifiableListView) return _addressRefs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addressRefs);
  }

  @override
  final WalletRef? walletRef;
  final List<ReservationRef> _reservationRefs;
  @override
  @JsonKey()
  List<ReservationRef> get reservationRefs {
    if (_reservationRefs is EqualUnmodifiableListView) return _reservationRefs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reservationRefs);
  }

  final List<PaymentMethodRef> _paymentMethodRefs;
  @override
  @JsonKey()
  List<PaymentMethodRef> get paymentMethodRefs {
    if (_paymentMethodRefs is EqualUnmodifiableListView)
      return _paymentMethodRefs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethodRefs);
  }

  // Verification flags
  @override
  @JsonKey()
  final bool isEmailVerified;
  @override
  @JsonKey()
  final bool isPhoneVerified;
  // Auditing
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  // Role-specific extra data (safe by design)
  final Map<String, dynamic> _roleMetadata;
  // Role-specific extra data (safe by design)
  @override
  @JsonKey()
  Map<String, dynamic> get roleMetadata {
    if (_roleMetadata is EqualUnmodifiableMapView) return _roleMetadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_roleMetadata);
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, roles: $roles, firstName: $firstName, lastName: $lastName, email: $email, contactNumber: $contactNumber, avatarUrl: $avatarUrl, addressRefs: $addressRefs, walletRef: $walletRef, reservationRefs: $reservationRefs, paymentMethodRefs: $paymentMethodRefs, isEmailVerified: $isEmailVerified, isPhoneVerified: $isPhoneVerified, createdAt: $createdAt, updatedAt: $updatedAt, roleMetadata: $roleMetadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
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
              other._addressRefs,
              _addressRefs,
            ) &&
            (identical(other.walletRef, walletRef) ||
                other.walletRef == walletRef) &&
            const DeepCollectionEquality().equals(
              other._reservationRefs,
              _reservationRefs,
            ) &&
            const DeepCollectionEquality().equals(
              other._paymentMethodRefs,
              _paymentMethodRefs,
            ) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.isPhoneVerified, isPhoneVerified) ||
                other.isPhoneVerified == isPhoneVerified) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(
              other._roleMetadata,
              _roleMetadata,
            ));
  }

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
    const DeepCollectionEquality().hash(_addressRefs),
    walletRef,
    const DeepCollectionEquality().hash(_reservationRefs),
    const DeepCollectionEquality().hash(_paymentMethodRefs),
    isEmailVerified,
    isPhoneVerified,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_roleMetadata),
  );

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    required final String id,
    final Set<UserRole> roles,
    required final String firstName,
    required final String lastName,
    required final String email,
    required final String contactNumber,
    final String? avatarUrl,
    final List<AddressRef> addressRefs,
    final WalletRef? walletRef,
    final List<ReservationRef> reservationRefs,
    final List<PaymentMethodRef> paymentMethodRefs,
    final bool isEmailVerified,
    final bool isPhoneVerified,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final Map<String, dynamic> roleMetadata,
  }) = _$UserProfileImpl;

  @override
  String get id;
  @override
  Set<UserRole> get roles; // Identity
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get contactNumber; // Media
  @override
  String? get avatarUrl; // Cross-feature refs
  @override
  List<AddressRef> get addressRefs;
  @override
  WalletRef? get walletRef;
  @override
  List<ReservationRef> get reservationRefs;
  @override
  List<PaymentMethodRef> get paymentMethodRefs; // Verification flags
  @override
  bool get isEmailVerified;
  @override
  bool get isPhoneVerified; // Auditing
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt; // Role-specific extra data (safe by design)
  @override
  Map<String, dynamic> get roleMetadata;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
