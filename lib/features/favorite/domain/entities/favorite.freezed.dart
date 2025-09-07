// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Favorite {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  FavoriteTargetType get targetType => throw _privateConstructorUsedError;
  String get targetId =>
      throw _privateConstructorUsedError; // ID of the product/vendor/etc.
  /// Optional snapshots for quick UI (avoid heavy joins).
  String? get titleSnapshot => throw _privateConstructorUsedError;
  String? get imageUrlSnapshot => throw _privateConstructorUsedError;
  String? get vendorIdSnapshot => throw _privateConstructorUsedError;

  /// Enables soft-delete without data loss.
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Favorite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteCopyWith<Favorite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteCopyWith<$Res> {
  factory $FavoriteCopyWith(Favorite value, $Res Function(Favorite) then) =
      _$FavoriteCopyWithImpl<$Res, Favorite>;
  @useResult
  $Res call({
    String id,
    String userId,
    FavoriteTargetType targetType,
    String targetId,
    String? titleSnapshot,
    String? imageUrlSnapshot,
    String? vendorIdSnapshot,
    bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$FavoriteCopyWithImpl<$Res, $Val extends Favorite>
    implements $FavoriteCopyWith<$Res> {
  _$FavoriteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Favorite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? targetType = null,
    Object? targetId = null,
    Object? titleSnapshot = freezed,
    Object? imageUrlSnapshot = freezed,
    Object? vendorIdSnapshot = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            targetType: null == targetType
                ? _value.targetType
                : targetType // ignore: cast_nullable_to_non_nullable
                      as FavoriteTargetType,
            targetId: null == targetId
                ? _value.targetId
                : targetId // ignore: cast_nullable_to_non_nullable
                      as String,
            titleSnapshot: freezed == titleSnapshot
                ? _value.titleSnapshot
                : titleSnapshot // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrlSnapshot: freezed == imageUrlSnapshot
                ? _value.imageUrlSnapshot
                : imageUrlSnapshot // ignore: cast_nullable_to_non_nullable
                      as String?,
            vendorIdSnapshot: freezed == vendorIdSnapshot
                ? _value.vendorIdSnapshot
                : vendorIdSnapshot // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FavoriteImplCopyWith<$Res>
    implements $FavoriteCopyWith<$Res> {
  factory _$$FavoriteImplCopyWith(
    _$FavoriteImpl value,
    $Res Function(_$FavoriteImpl) then,
  ) = __$$FavoriteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    FavoriteTargetType targetType,
    String targetId,
    String? titleSnapshot,
    String? imageUrlSnapshot,
    String? vendorIdSnapshot,
    bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$FavoriteImplCopyWithImpl<$Res>
    extends _$FavoriteCopyWithImpl<$Res, _$FavoriteImpl>
    implements _$$FavoriteImplCopyWith<$Res> {
  __$$FavoriteImplCopyWithImpl(
    _$FavoriteImpl _value,
    $Res Function(_$FavoriteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Favorite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? targetType = null,
    Object? targetId = null,
    Object? titleSnapshot = freezed,
    Object? imageUrlSnapshot = freezed,
    Object? vendorIdSnapshot = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$FavoriteImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        targetType: null == targetType
            ? _value.targetType
            : targetType // ignore: cast_nullable_to_non_nullable
                  as FavoriteTargetType,
        targetId: null == targetId
            ? _value.targetId
            : targetId // ignore: cast_nullable_to_non_nullable
                  as String,
        titleSnapshot: freezed == titleSnapshot
            ? _value.titleSnapshot
            : titleSnapshot // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrlSnapshot: freezed == imageUrlSnapshot
            ? _value.imageUrlSnapshot
            : imageUrlSnapshot // ignore: cast_nullable_to_non_nullable
                  as String?,
        vendorIdSnapshot: freezed == vendorIdSnapshot
            ? _value.vendorIdSnapshot
            : vendorIdSnapshot // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$FavoriteImpl implements _Favorite {
  const _$FavoriteImpl({
    required this.id,
    required this.userId,
    required this.targetType,
    required this.targetId,
    this.titleSnapshot,
    this.imageUrlSnapshot,
    this.vendorIdSnapshot,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  @override
  final String id;
  @override
  final String userId;
  @override
  final FavoriteTargetType targetType;
  @override
  final String targetId;
  // ID of the product/vendor/etc.
  /// Optional snapshots for quick UI (avoid heavy joins).
  @override
  final String? titleSnapshot;
  @override
  final String? imageUrlSnapshot;
  @override
  final String? vendorIdSnapshot;

  /// Enables soft-delete without data loss.
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Favorite(id: $id, userId: $userId, targetType: $targetType, targetId: $targetId, titleSnapshot: $titleSnapshot, imageUrlSnapshot: $imageUrlSnapshot, vendorIdSnapshot: $vendorIdSnapshot, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.targetType, targetType) ||
                other.targetType == targetType) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.titleSnapshot, titleSnapshot) ||
                other.titleSnapshot == titleSnapshot) &&
            (identical(other.imageUrlSnapshot, imageUrlSnapshot) ||
                other.imageUrlSnapshot == imageUrlSnapshot) &&
            (identical(other.vendorIdSnapshot, vendorIdSnapshot) ||
                other.vendorIdSnapshot == vendorIdSnapshot) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    targetType,
    targetId,
    titleSnapshot,
    imageUrlSnapshot,
    vendorIdSnapshot,
    isActive,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Favorite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteImplCopyWith<_$FavoriteImpl> get copyWith =>
      __$$FavoriteImplCopyWithImpl<_$FavoriteImpl>(this, _$identity);
}

abstract class _Favorite implements Favorite {
  const factory _Favorite({
    required final String id,
    required final String userId,
    required final FavoriteTargetType targetType,
    required final String targetId,
    final String? titleSnapshot,
    final String? imageUrlSnapshot,
    final String? vendorIdSnapshot,
    final bool isActive,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$FavoriteImpl;

  @override
  String get id;
  @override
  String get userId;
  @override
  FavoriteTargetType get targetType;
  @override
  String get targetId; // ID of the product/vendor/etc.
  /// Optional snapshots for quick UI (avoid heavy joins).
  @override
  String? get titleSnapshot;
  @override
  String? get imageUrlSnapshot;
  @override
  String? get vendorIdSnapshot;

  /// Enables soft-delete without data loss.
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Favorite
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteImplCopyWith<_$FavoriteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
