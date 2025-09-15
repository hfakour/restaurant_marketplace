// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FavoriteRef {
  String get favoriteId => throw _privateConstructorUsedError;
  String? get targetIdSnapshot => throw _privateConstructorUsedError;
  String? get titleSnapshot => throw _privateConstructorUsedError;
  String? get imageUrlSnapshot => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteRefCopyWith<FavoriteRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteRefCopyWith<$Res> {
  factory $FavoriteRefCopyWith(
    FavoriteRef value,
    $Res Function(FavoriteRef) then,
  ) = _$FavoriteRefCopyWithImpl<$Res, FavoriteRef>;
  @useResult
  $Res call({
    String favoriteId,
    String? targetIdSnapshot,
    String? titleSnapshot,
    String? imageUrlSnapshot,
    bool isActive,
  });
}

/// @nodoc
class _$FavoriteRefCopyWithImpl<$Res, $Val extends FavoriteRef>
    implements $FavoriteRefCopyWith<$Res> {
  _$FavoriteRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteId = null,
    Object? targetIdSnapshot = freezed,
    Object? titleSnapshot = freezed,
    Object? imageUrlSnapshot = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            favoriteId: null == favoriteId
                ? _value.favoriteId
                : favoriteId // ignore: cast_nullable_to_non_nullable
                      as String,
            targetIdSnapshot: freezed == targetIdSnapshot
                ? _value.targetIdSnapshot
                : targetIdSnapshot // ignore: cast_nullable_to_non_nullable
                      as String?,
            titleSnapshot: freezed == titleSnapshot
                ? _value.titleSnapshot
                : titleSnapshot // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrlSnapshot: freezed == imageUrlSnapshot
                ? _value.imageUrlSnapshot
                : imageUrlSnapshot // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FavoriteRefImplCopyWith<$Res>
    implements $FavoriteRefCopyWith<$Res> {
  factory _$$FavoriteRefImplCopyWith(
    _$FavoriteRefImpl value,
    $Res Function(_$FavoriteRefImpl) then,
  ) = __$$FavoriteRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String favoriteId,
    String? targetIdSnapshot,
    String? titleSnapshot,
    String? imageUrlSnapshot,
    bool isActive,
  });
}

/// @nodoc
class __$$FavoriteRefImplCopyWithImpl<$Res>
    extends _$FavoriteRefCopyWithImpl<$Res, _$FavoriteRefImpl>
    implements _$$FavoriteRefImplCopyWith<$Res> {
  __$$FavoriteRefImplCopyWithImpl(
    _$FavoriteRefImpl _value,
    $Res Function(_$FavoriteRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoriteRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteId = null,
    Object? targetIdSnapshot = freezed,
    Object? titleSnapshot = freezed,
    Object? imageUrlSnapshot = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$FavoriteRefImpl(
        favoriteId: null == favoriteId
            ? _value.favoriteId
            : favoriteId // ignore: cast_nullable_to_non_nullable
                  as String,
        targetIdSnapshot: freezed == targetIdSnapshot
            ? _value.targetIdSnapshot
            : targetIdSnapshot // ignore: cast_nullable_to_non_nullable
                  as String?,
        titleSnapshot: freezed == titleSnapshot
            ? _value.titleSnapshot
            : titleSnapshot // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrlSnapshot: freezed == imageUrlSnapshot
            ? _value.imageUrlSnapshot
            : imageUrlSnapshot // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$FavoriteRefImpl implements _FavoriteRef {
  const _$FavoriteRefImpl({
    required this.favoriteId,
    this.targetIdSnapshot,
    this.titleSnapshot,
    this.imageUrlSnapshot,
    this.isActive = true,
  });

  @override
  final String favoriteId;
  @override
  final String? targetIdSnapshot;
  @override
  final String? titleSnapshot;
  @override
  final String? imageUrlSnapshot;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'FavoriteRef(favoriteId: $favoriteId, targetIdSnapshot: $targetIdSnapshot, titleSnapshot: $titleSnapshot, imageUrlSnapshot: $imageUrlSnapshot, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteRefImpl &&
            (identical(other.favoriteId, favoriteId) ||
                other.favoriteId == favoriteId) &&
            (identical(other.targetIdSnapshot, targetIdSnapshot) ||
                other.targetIdSnapshot == targetIdSnapshot) &&
            (identical(other.titleSnapshot, titleSnapshot) ||
                other.titleSnapshot == titleSnapshot) &&
            (identical(other.imageUrlSnapshot, imageUrlSnapshot) ||
                other.imageUrlSnapshot == imageUrlSnapshot) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    favoriteId,
    targetIdSnapshot,
    titleSnapshot,
    imageUrlSnapshot,
    isActive,
  );

  /// Create a copy of FavoriteRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteRefImplCopyWith<_$FavoriteRefImpl> get copyWith =>
      __$$FavoriteRefImplCopyWithImpl<_$FavoriteRefImpl>(this, _$identity);
}

abstract class _FavoriteRef implements FavoriteRef {
  const factory _FavoriteRef({
    required final String favoriteId,
    final String? targetIdSnapshot,
    final String? titleSnapshot,
    final String? imageUrlSnapshot,
    final bool isActive,
  }) = _$FavoriteRefImpl;

  @override
  String get favoriteId;
  @override
  String? get targetIdSnapshot;
  @override
  String? get titleSnapshot;
  @override
  String? get imageUrlSnapshot;
  @override
  bool get isActive;

  /// Create a copy of FavoriteRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteRefImplCopyWith<_$FavoriteRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
