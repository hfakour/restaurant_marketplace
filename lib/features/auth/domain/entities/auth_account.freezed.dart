// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthAccount {
  /// Firebase UID (stable id)
  String get id => throw _privateConstructorUsedError;

  /// May be null for anonymous/phone flows
  String? get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  bool get isEmailVerified => throw _privateConstructorUsedError;
  bool get isPhoneVerified => throw _privateConstructorUsedError;

  /// Linked providers (password/google/apple/phone/anonymous)
  Set<AuthProvider> get providers => throw _privateConstructorUsedError;

  /// 1:1 mapping to your UserProfile.id (we use UID)
  String get profileId => throw _privateConstructorUsedError;

  /// Auditing
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;

  /// Provider/backend-specific metadata (safe to store)
  Map<String, dynamic> get providerMetadata =>
      throw _privateConstructorUsedError;

  /// Create a copy of AuthAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthAccountCopyWith<AuthAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthAccountCopyWith<$Res> {
  factory $AuthAccountCopyWith(
    AuthAccount value,
    $Res Function(AuthAccount) then,
  ) = _$AuthAccountCopyWithImpl<$Res, AuthAccount>;
  @useResult
  $Res call({
    String id,
    String? email,
    String? displayName,
    String? avatarUrl,
    bool isEmailVerified,
    bool isPhoneVerified,
    Set<AuthProvider> providers,
    String profileId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    Map<String, dynamic> providerMetadata,
  });
}

/// @nodoc
class _$AuthAccountCopyWithImpl<$Res, $Val extends AuthAccount>
    implements $AuthAccountCopyWith<$Res> {
  _$AuthAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? isEmailVerified = null,
    Object? isPhoneVerified = null,
    Object? providers = null,
    Object? profileId = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastLoginAt = freezed,
    Object? providerMetadata = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isEmailVerified: null == isEmailVerified
                ? _value.isEmailVerified
                : isEmailVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPhoneVerified: null == isPhoneVerified
                ? _value.isPhoneVerified
                : isPhoneVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            providers: null == providers
                ? _value.providers
                : providers // ignore: cast_nullable_to_non_nullable
                      as Set<AuthProvider>,
            profileId: null == profileId
                ? _value.profileId
                : profileId // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastLoginAt: freezed == lastLoginAt
                ? _value.lastLoginAt
                : lastLoginAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            providerMetadata: null == providerMetadata
                ? _value.providerMetadata
                : providerMetadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthAccountImplCopyWith<$Res>
    implements $AuthAccountCopyWith<$Res> {
  factory _$$AuthAccountImplCopyWith(
    _$AuthAccountImpl value,
    $Res Function(_$AuthAccountImpl) then,
  ) = __$$AuthAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? email,
    String? displayName,
    String? avatarUrl,
    bool isEmailVerified,
    bool isPhoneVerified,
    Set<AuthProvider> providers,
    String profileId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    Map<String, dynamic> providerMetadata,
  });
}

/// @nodoc
class __$$AuthAccountImplCopyWithImpl<$Res>
    extends _$AuthAccountCopyWithImpl<$Res, _$AuthAccountImpl>
    implements _$$AuthAccountImplCopyWith<$Res> {
  __$$AuthAccountImplCopyWithImpl(
    _$AuthAccountImpl _value,
    $Res Function(_$AuthAccountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? isEmailVerified = null,
    Object? isPhoneVerified = null,
    Object? providers = null,
    Object? profileId = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastLoginAt = freezed,
    Object? providerMetadata = null,
  }) {
    return _then(
      _$AuthAccountImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isEmailVerified: null == isEmailVerified
            ? _value.isEmailVerified
            : isEmailVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPhoneVerified: null == isPhoneVerified
            ? _value.isPhoneVerified
            : isPhoneVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        providers: null == providers
            ? _value._providers
            : providers // ignore: cast_nullable_to_non_nullable
                  as Set<AuthProvider>,
        profileId: null == profileId
            ? _value.profileId
            : profileId // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastLoginAt: freezed == lastLoginAt
            ? _value.lastLoginAt
            : lastLoginAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        providerMetadata: null == providerMetadata
            ? _value._providerMetadata
            : providerMetadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$AuthAccountImpl implements _AuthAccount {
  const _$AuthAccountImpl({
    required this.id,
    this.email,
    this.displayName,
    this.avatarUrl,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    final Set<AuthProvider> providers = const <AuthProvider>{},
    required this.profileId,
    this.createdAt,
    this.updatedAt,
    this.lastLoginAt,
    final Map<String, dynamic> providerMetadata = const <String, dynamic>{},
  }) : _providers = providers,
       _providerMetadata = providerMetadata;

  /// Firebase UID (stable id)
  @override
  final String id;

  /// May be null for anonymous/phone flows
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? avatarUrl;
  @override
  @JsonKey()
  final bool isEmailVerified;
  @override
  @JsonKey()
  final bool isPhoneVerified;

  /// Linked providers (password/google/apple/phone/anonymous)
  final Set<AuthProvider> _providers;

  /// Linked providers (password/google/apple/phone/anonymous)
  @override
  @JsonKey()
  Set<AuthProvider> get providers {
    if (_providers is EqualUnmodifiableSetView) return _providers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_providers);
  }

  /// 1:1 mapping to your UserProfile.id (we use UID)
  @override
  final String profileId;

  /// Auditing
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? lastLoginAt;

  /// Provider/backend-specific metadata (safe to store)
  final Map<String, dynamic> _providerMetadata;

  /// Provider/backend-specific metadata (safe to store)
  @override
  @JsonKey()
  Map<String, dynamic> get providerMetadata {
    if (_providerMetadata is EqualUnmodifiableMapView) return _providerMetadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_providerMetadata);
  }

  @override
  String toString() {
    return 'AuthAccount(id: $id, email: $email, displayName: $displayName, avatarUrl: $avatarUrl, isEmailVerified: $isEmailVerified, isPhoneVerified: $isPhoneVerified, providers: $providers, profileId: $profileId, createdAt: $createdAt, updatedAt: $updatedAt, lastLoginAt: $lastLoginAt, providerMetadata: $providerMetadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthAccountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.isPhoneVerified, isPhoneVerified) ||
                other.isPhoneVerified == isPhoneVerified) &&
            const DeepCollectionEquality().equals(
              other._providers,
              _providers,
            ) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            const DeepCollectionEquality().equals(
              other._providerMetadata,
              _providerMetadata,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    displayName,
    avatarUrl,
    isEmailVerified,
    isPhoneVerified,
    const DeepCollectionEquality().hash(_providers),
    profileId,
    createdAt,
    updatedAt,
    lastLoginAt,
    const DeepCollectionEquality().hash(_providerMetadata),
  );

  /// Create a copy of AuthAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthAccountImplCopyWith<_$AuthAccountImpl> get copyWith =>
      __$$AuthAccountImplCopyWithImpl<_$AuthAccountImpl>(this, _$identity);
}

abstract class _AuthAccount implements AuthAccount {
  const factory _AuthAccount({
    required final String id,
    final String? email,
    final String? displayName,
    final String? avatarUrl,
    final bool isEmailVerified,
    final bool isPhoneVerified,
    final Set<AuthProvider> providers,
    required final String profileId,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final DateTime? lastLoginAt,
    final Map<String, dynamic> providerMetadata,
  }) = _$AuthAccountImpl;

  /// Firebase UID (stable id)
  @override
  String get id;

  /// May be null for anonymous/phone flows
  @override
  String? get email;
  @override
  String? get displayName;
  @override
  String? get avatarUrl;
  @override
  bool get isEmailVerified;
  @override
  bool get isPhoneVerified;

  /// Linked providers (password/google/apple/phone/anonymous)
  @override
  Set<AuthProvider> get providers;

  /// 1:1 mapping to your UserProfile.id (we use UID)
  @override
  String get profileId;

  /// Auditing
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get lastLoginAt;

  /// Provider/backend-specific metadata (safe to store)
  @override
  Map<String, dynamic> get providerMetadata;

  /// Create a copy of AuthAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthAccountImplCopyWith<_$AuthAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
