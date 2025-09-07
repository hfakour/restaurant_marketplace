// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discount_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DiscountRef {
  String get discountId => throw _privateConstructorUsedError;

  /// Minimal snapshot fields for checkout UI.
  String? get codeSnapshot => throw _privateConstructorUsedError;
  double? get percentageSnapshot => throw _privateConstructorUsedError;
  double? get fixedAmountSnapshot => throw _privateConstructorUsedError;
  String? get currencyCode => throw _privateConstructorUsedError;
  DateTime? get snapshotAt => throw _privateConstructorUsedError;

  /// Whether it was stackable at the time it was added.
  bool get wasStackable => throw _privateConstructorUsedError;

  /// Create a copy of DiscountRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscountRefCopyWith<DiscountRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscountRefCopyWith<$Res> {
  factory $DiscountRefCopyWith(
    DiscountRef value,
    $Res Function(DiscountRef) then,
  ) = _$DiscountRefCopyWithImpl<$Res, DiscountRef>;
  @useResult
  $Res call({
    String discountId,
    String? codeSnapshot,
    double? percentageSnapshot,
    double? fixedAmountSnapshot,
    String? currencyCode,
    DateTime? snapshotAt,
    bool wasStackable,
  });
}

/// @nodoc
class _$DiscountRefCopyWithImpl<$Res, $Val extends DiscountRef>
    implements $DiscountRefCopyWith<$Res> {
  _$DiscountRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscountRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discountId = null,
    Object? codeSnapshot = freezed,
    Object? percentageSnapshot = freezed,
    Object? fixedAmountSnapshot = freezed,
    Object? currencyCode = freezed,
    Object? snapshotAt = freezed,
    Object? wasStackable = null,
  }) {
    return _then(
      _value.copyWith(
            discountId: null == discountId
                ? _value.discountId
                : discountId // ignore: cast_nullable_to_non_nullable
                      as String,
            codeSnapshot: freezed == codeSnapshot
                ? _value.codeSnapshot
                : codeSnapshot // ignore: cast_nullable_to_non_nullable
                      as String?,
            percentageSnapshot: freezed == percentageSnapshot
                ? _value.percentageSnapshot
                : percentageSnapshot // ignore: cast_nullable_to_non_nullable
                      as double?,
            fixedAmountSnapshot: freezed == fixedAmountSnapshot
                ? _value.fixedAmountSnapshot
                : fixedAmountSnapshot // ignore: cast_nullable_to_non_nullable
                      as double?,
            currencyCode: freezed == currencyCode
                ? _value.currencyCode
                : currencyCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            snapshotAt: freezed == snapshotAt
                ? _value.snapshotAt
                : snapshotAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            wasStackable: null == wasStackable
                ? _value.wasStackable
                : wasStackable // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscountRefImplCopyWith<$Res>
    implements $DiscountRefCopyWith<$Res> {
  factory _$$DiscountRefImplCopyWith(
    _$DiscountRefImpl value,
    $Res Function(_$DiscountRefImpl) then,
  ) = __$$DiscountRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String discountId,
    String? codeSnapshot,
    double? percentageSnapshot,
    double? fixedAmountSnapshot,
    String? currencyCode,
    DateTime? snapshotAt,
    bool wasStackable,
  });
}

/// @nodoc
class __$$DiscountRefImplCopyWithImpl<$Res>
    extends _$DiscountRefCopyWithImpl<$Res, _$DiscountRefImpl>
    implements _$$DiscountRefImplCopyWith<$Res> {
  __$$DiscountRefImplCopyWithImpl(
    _$DiscountRefImpl _value,
    $Res Function(_$DiscountRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscountRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discountId = null,
    Object? codeSnapshot = freezed,
    Object? percentageSnapshot = freezed,
    Object? fixedAmountSnapshot = freezed,
    Object? currencyCode = freezed,
    Object? snapshotAt = freezed,
    Object? wasStackable = null,
  }) {
    return _then(
      _$DiscountRefImpl(
        discountId: null == discountId
            ? _value.discountId
            : discountId // ignore: cast_nullable_to_non_nullable
                  as String,
        codeSnapshot: freezed == codeSnapshot
            ? _value.codeSnapshot
            : codeSnapshot // ignore: cast_nullable_to_non_nullable
                  as String?,
        percentageSnapshot: freezed == percentageSnapshot
            ? _value.percentageSnapshot
            : percentageSnapshot // ignore: cast_nullable_to_non_nullable
                  as double?,
        fixedAmountSnapshot: freezed == fixedAmountSnapshot
            ? _value.fixedAmountSnapshot
            : fixedAmountSnapshot // ignore: cast_nullable_to_non_nullable
                  as double?,
        currencyCode: freezed == currencyCode
            ? _value.currencyCode
            : currencyCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        snapshotAt: freezed == snapshotAt
            ? _value.snapshotAt
            : snapshotAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        wasStackable: null == wasStackable
            ? _value.wasStackable
            : wasStackable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$DiscountRefImpl implements _DiscountRef {
  const _$DiscountRefImpl({
    required this.discountId,
    this.codeSnapshot,
    this.percentageSnapshot,
    this.fixedAmountSnapshot,
    this.currencyCode,
    this.snapshotAt,
    this.wasStackable = false,
  });

  @override
  final String discountId;

  /// Minimal snapshot fields for checkout UI.
  @override
  final String? codeSnapshot;
  @override
  final double? percentageSnapshot;
  @override
  final double? fixedAmountSnapshot;
  @override
  final String? currencyCode;
  @override
  final DateTime? snapshotAt;

  /// Whether it was stackable at the time it was added.
  @override
  @JsonKey()
  final bool wasStackable;

  @override
  String toString() {
    return 'DiscountRef(discountId: $discountId, codeSnapshot: $codeSnapshot, percentageSnapshot: $percentageSnapshot, fixedAmountSnapshot: $fixedAmountSnapshot, currencyCode: $currencyCode, snapshotAt: $snapshotAt, wasStackable: $wasStackable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscountRefImpl &&
            (identical(other.discountId, discountId) ||
                other.discountId == discountId) &&
            (identical(other.codeSnapshot, codeSnapshot) ||
                other.codeSnapshot == codeSnapshot) &&
            (identical(other.percentageSnapshot, percentageSnapshot) ||
                other.percentageSnapshot == percentageSnapshot) &&
            (identical(other.fixedAmountSnapshot, fixedAmountSnapshot) ||
                other.fixedAmountSnapshot == fixedAmountSnapshot) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.snapshotAt, snapshotAt) ||
                other.snapshotAt == snapshotAt) &&
            (identical(other.wasStackable, wasStackable) ||
                other.wasStackable == wasStackable));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    discountId,
    codeSnapshot,
    percentageSnapshot,
    fixedAmountSnapshot,
    currencyCode,
    snapshotAt,
    wasStackable,
  );

  /// Create a copy of DiscountRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscountRefImplCopyWith<_$DiscountRefImpl> get copyWith =>
      __$$DiscountRefImplCopyWithImpl<_$DiscountRefImpl>(this, _$identity);
}

abstract class _DiscountRef implements DiscountRef {
  const factory _DiscountRef({
    required final String discountId,
    final String? codeSnapshot,
    final double? percentageSnapshot,
    final double? fixedAmountSnapshot,
    final String? currencyCode,
    final DateTime? snapshotAt,
    final bool wasStackable,
  }) = _$DiscountRefImpl;

  @override
  String get discountId;

  /// Minimal snapshot fields for checkout UI.
  @override
  String? get codeSnapshot;
  @override
  double? get percentageSnapshot;
  @override
  double? get fixedAmountSnapshot;
  @override
  String? get currencyCode;
  @override
  DateTime? get snapshotAt;

  /// Whether it was stackable at the time it was added.
  @override
  bool get wasStackable;

  /// Create a copy of DiscountRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscountRefImplCopyWith<_$DiscountRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
