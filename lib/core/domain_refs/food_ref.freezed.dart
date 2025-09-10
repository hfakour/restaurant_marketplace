// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FoodRef {
  String get foodId => throw _privateConstructorUsedError;
  String? get nameSnapshot =>
      throw _privateConstructorUsedError; // e.g., "Margherita Pizza"
  int? get priceCentsSnapshot =>
      throw _privateConstructorUsedError; // lightweight price display
  String? get imageUrlSnapshot =>
      throw _privateConstructorUsedError; // thumbnail image
  bool get isAvailable => throw _privateConstructorUsedError;

  /// Create a copy of FoodRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodRefCopyWith<FoodRef> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodRefCopyWith<$Res> {
  factory $FoodRefCopyWith(FoodRef value, $Res Function(FoodRef) then) =
      _$FoodRefCopyWithImpl<$Res, FoodRef>;
  @useResult
  $Res call({
    String foodId,
    String? nameSnapshot,
    int? priceCentsSnapshot,
    String? imageUrlSnapshot,
    bool isAvailable,
  });
}

/// @nodoc
class _$FoodRefCopyWithImpl<$Res, $Val extends FoodRef>
    implements $FoodRefCopyWith<$Res> {
  _$FoodRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodId = null,
    Object? nameSnapshot = freezed,
    Object? priceCentsSnapshot = freezed,
    Object? imageUrlSnapshot = freezed,
    Object? isAvailable = null,
  }) {
    return _then(
      _value.copyWith(
            foodId: null == foodId
                ? _value.foodId
                : foodId // ignore: cast_nullable_to_non_nullable
                      as String,
            nameSnapshot: freezed == nameSnapshot
                ? _value.nameSnapshot
                : nameSnapshot // ignore: cast_nullable_to_non_nullable
                      as String?,
            priceCentsSnapshot: freezed == priceCentsSnapshot
                ? _value.priceCentsSnapshot
                : priceCentsSnapshot // ignore: cast_nullable_to_non_nullable
                      as int?,
            imageUrlSnapshot: freezed == imageUrlSnapshot
                ? _value.imageUrlSnapshot
                : imageUrlSnapshot // ignore: cast_nullable_to_non_nullable
                      as String?,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FoodRefImplCopyWith<$Res> implements $FoodRefCopyWith<$Res> {
  factory _$$FoodRefImplCopyWith(
    _$FoodRefImpl value,
    $Res Function(_$FoodRefImpl) then,
  ) = __$$FoodRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String foodId,
    String? nameSnapshot,
    int? priceCentsSnapshot,
    String? imageUrlSnapshot,
    bool isAvailable,
  });
}

/// @nodoc
class __$$FoodRefImplCopyWithImpl<$Res>
    extends _$FoodRefCopyWithImpl<$Res, _$FoodRefImpl>
    implements _$$FoodRefImplCopyWith<$Res> {
  __$$FoodRefImplCopyWithImpl(
    _$FoodRefImpl _value,
    $Res Function(_$FoodRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FoodRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodId = null,
    Object? nameSnapshot = freezed,
    Object? priceCentsSnapshot = freezed,
    Object? imageUrlSnapshot = freezed,
    Object? isAvailable = null,
  }) {
    return _then(
      _$FoodRefImpl(
        foodId: null == foodId
            ? _value.foodId
            : foodId // ignore: cast_nullable_to_non_nullable
                  as String,
        nameSnapshot: freezed == nameSnapshot
            ? _value.nameSnapshot
            : nameSnapshot // ignore: cast_nullable_to_non_nullable
                  as String?,
        priceCentsSnapshot: freezed == priceCentsSnapshot
            ? _value.priceCentsSnapshot
            : priceCentsSnapshot // ignore: cast_nullable_to_non_nullable
                  as int?,
        imageUrlSnapshot: freezed == imageUrlSnapshot
            ? _value.imageUrlSnapshot
            : imageUrlSnapshot // ignore: cast_nullable_to_non_nullable
                  as String?,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$FoodRefImpl implements _FoodRef {
  const _$FoodRefImpl({
    required this.foodId,
    this.nameSnapshot,
    this.priceCentsSnapshot,
    this.imageUrlSnapshot,
    this.isAvailable = true,
  });

  @override
  final String foodId;
  @override
  final String? nameSnapshot;
  // e.g., "Margherita Pizza"
  @override
  final int? priceCentsSnapshot;
  // lightweight price display
  @override
  final String? imageUrlSnapshot;
  // thumbnail image
  @override
  @JsonKey()
  final bool isAvailable;

  @override
  String toString() {
    return 'FoodRef(foodId: $foodId, nameSnapshot: $nameSnapshot, priceCentsSnapshot: $priceCentsSnapshot, imageUrlSnapshot: $imageUrlSnapshot, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodRefImpl &&
            (identical(other.foodId, foodId) || other.foodId == foodId) &&
            (identical(other.nameSnapshot, nameSnapshot) ||
                other.nameSnapshot == nameSnapshot) &&
            (identical(other.priceCentsSnapshot, priceCentsSnapshot) ||
                other.priceCentsSnapshot == priceCentsSnapshot) &&
            (identical(other.imageUrlSnapshot, imageUrlSnapshot) ||
                other.imageUrlSnapshot == imageUrlSnapshot) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    foodId,
    nameSnapshot,
    priceCentsSnapshot,
    imageUrlSnapshot,
    isAvailable,
  );

  /// Create a copy of FoodRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodRefImplCopyWith<_$FoodRefImpl> get copyWith =>
      __$$FoodRefImplCopyWithImpl<_$FoodRefImpl>(this, _$identity);
}

abstract class _FoodRef implements FoodRef {
  const factory _FoodRef({
    required final String foodId,
    final String? nameSnapshot,
    final int? priceCentsSnapshot,
    final String? imageUrlSnapshot,
    final bool isAvailable,
  }) = _$FoodRefImpl;

  @override
  String get foodId;
  @override
  String? get nameSnapshot; // e.g., "Margherita Pizza"
  @override
  int? get priceCentsSnapshot; // lightweight price display
  @override
  String? get imageUrlSnapshot; // thumbnail image
  @override
  bool get isAvailable;

  /// Create a copy of FoodRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodRefImplCopyWith<_$FoodRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
