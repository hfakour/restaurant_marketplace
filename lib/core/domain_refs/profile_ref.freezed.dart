// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserProfileRef {
  String get userId => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get contactNumber => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileRefCopyWith<UserProfileRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileRefCopyWith<$Res> {
  factory $UserProfileRefCopyWith(
    UserProfileRef value,
    $Res Function(UserProfileRef) then,
  ) = _$UserProfileRefCopyWithImpl<$Res, UserProfileRef>;
  @useResult
  $Res call({
    String userId,
    String? displayName,
    String? avatarUrl,
    String? contactNumber,
  });
}

/// @nodoc
class _$UserProfileRefCopyWithImpl<$Res, $Val extends UserProfileRef>
    implements $UserProfileRefCopyWith<$Res> {
  _$UserProfileRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? contactNumber = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            contactNumber: freezed == contactNumber
                ? _value.contactNumber
                : contactNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileRefImplCopyWith<$Res>
    implements $UserProfileRefCopyWith<$Res> {
  factory _$$UserProfileRefImplCopyWith(
    _$UserProfileRefImpl value,
    $Res Function(_$UserProfileRefImpl) then,
  ) = __$$UserProfileRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String? displayName,
    String? avatarUrl,
    String? contactNumber,
  });
}

/// @nodoc
class __$$UserProfileRefImplCopyWithImpl<$Res>
    extends _$UserProfileRefCopyWithImpl<$Res, _$UserProfileRefImpl>
    implements _$$UserProfileRefImplCopyWith<$Res> {
  __$$UserProfileRefImplCopyWithImpl(
    _$UserProfileRefImpl _value,
    $Res Function(_$UserProfileRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfileRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? contactNumber = freezed,
  }) {
    return _then(
      _$UserProfileRefImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        contactNumber: freezed == contactNumber
            ? _value.contactNumber
            : contactNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$UserProfileRefImpl implements _UserProfileRef {
  const _$UserProfileRefImpl({
    required this.userId,
    this.displayName,
    this.avatarUrl,
    this.contactNumber,
  });

  @override
  final String userId;
  @override
  final String? displayName;
  @override
  final String? avatarUrl;
  @override
  final String? contactNumber;

  @override
  String toString() {
    return 'UserProfileRef(userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, contactNumber: $contactNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileRefImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, displayName, avatarUrl, contactNumber);

  /// Create a copy of UserProfileRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileRefImplCopyWith<_$UserProfileRefImpl> get copyWith =>
      __$$UserProfileRefImplCopyWithImpl<_$UserProfileRefImpl>(
        this,
        _$identity,
      );
}

abstract class _UserProfileRef implements UserProfileRef {
  const factory _UserProfileRef({
    required final String userId,
    final String? displayName,
    final String? avatarUrl,
    final String? contactNumber,
  }) = _$UserProfileRefImpl;

  @override
  String get userId;
  @override
  String? get displayName;
  @override
  String? get avatarUrl;
  @override
  String? get contactNumber;

  /// Create a copy of UserProfileRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileRefImplCopyWith<_$UserProfileRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
