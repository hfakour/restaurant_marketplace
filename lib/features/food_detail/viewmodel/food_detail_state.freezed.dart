// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FoodDetailState {
  int get quantity => throw _privateConstructorUsedError;
  String get selectedSize => throw _privateConstructorUsedError;
  bool get extraCheese => throw _privateConstructorUsedError;

  /// Create a copy of FoodDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodDetailStateCopyWith<FoodDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodDetailStateCopyWith<$Res> {
  factory $FoodDetailStateCopyWith(
    FoodDetailState value,
    $Res Function(FoodDetailState) then,
  ) = _$FoodDetailStateCopyWithImpl<$Res, FoodDetailState>;
  @useResult
  $Res call({int quantity, String selectedSize, bool extraCheese});
}

/// @nodoc
class _$FoodDetailStateCopyWithImpl<$Res, $Val extends FoodDetailState>
    implements $FoodDetailStateCopyWith<$Res> {
  _$FoodDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? selectedSize = null,
    Object? extraCheese = null,
  }) {
    return _then(
      _value.copyWith(
            quantity:
                null == quantity
                    ? _value.quantity
                    : quantity // ignore: cast_nullable_to_non_nullable
                        as int,
            selectedSize:
                null == selectedSize
                    ? _value.selectedSize
                    : selectedSize // ignore: cast_nullable_to_non_nullable
                        as String,
            extraCheese:
                null == extraCheese
                    ? _value.extraCheese
                    : extraCheese // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FoodDetailStateImplCopyWith<$Res>
    implements $FoodDetailStateCopyWith<$Res> {
  factory _$$FoodDetailStateImplCopyWith(
    _$FoodDetailStateImpl value,
    $Res Function(_$FoodDetailStateImpl) then,
  ) = __$$FoodDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int quantity, String selectedSize, bool extraCheese});
}

/// @nodoc
class __$$FoodDetailStateImplCopyWithImpl<$Res>
    extends _$FoodDetailStateCopyWithImpl<$Res, _$FoodDetailStateImpl>
    implements _$$FoodDetailStateImplCopyWith<$Res> {
  __$$FoodDetailStateImplCopyWithImpl(
    _$FoodDetailStateImpl _value,
    $Res Function(_$FoodDetailStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FoodDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? selectedSize = null,
    Object? extraCheese = null,
  }) {
    return _then(
      _$FoodDetailStateImpl(
        quantity:
            null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                    as int,
        selectedSize:
            null == selectedSize
                ? _value.selectedSize
                : selectedSize // ignore: cast_nullable_to_non_nullable
                    as String,
        extraCheese:
            null == extraCheese
                ? _value.extraCheese
                : extraCheese // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$FoodDetailStateImpl implements _FoodDetailState {
  const _$FoodDetailStateImpl({
    this.quantity = 1,
    this.selectedSize = 'Regular',
    this.extraCheese = false,
  });

  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey()
  final String selectedSize;
  @override
  @JsonKey()
  final bool extraCheese;

  @override
  String toString() {
    return 'FoodDetailState(quantity: $quantity, selectedSize: $selectedSize, extraCheese: $extraCheese)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodDetailStateImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.selectedSize, selectedSize) ||
                other.selectedSize == selectedSize) &&
            (identical(other.extraCheese, extraCheese) ||
                other.extraCheese == extraCheese));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, quantity, selectedSize, extraCheese);

  /// Create a copy of FoodDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodDetailStateImplCopyWith<_$FoodDetailStateImpl> get copyWith =>
      __$$FoodDetailStateImplCopyWithImpl<_$FoodDetailStateImpl>(
        this,
        _$identity,
      );
}

abstract class _FoodDetailState implements FoodDetailState {
  const factory _FoodDetailState({
    final int quantity,
    final String selectedSize,
    final bool extraCheese,
  }) = _$FoodDetailStateImpl;

  @override
  int get quantity;
  @override
  String get selectedSize;
  @override
  bool get extraCheese;

  /// Create a copy of FoodDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodDetailStateImplCopyWith<_$FoodDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
