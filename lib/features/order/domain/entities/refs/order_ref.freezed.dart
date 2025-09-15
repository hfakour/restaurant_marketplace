// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OrderRef {
  String get orderId => throw _privateConstructorUsedError;

  /// Minimal UI snapshot fields to avoid depending on Money in light refs.
  double? get grandTotalSnapshot => throw _privateConstructorUsedError;
  String? get currencyCode => throw _privateConstructorUsedError;
  OrderStatusSnapshot? get statusSnapshot => throw _privateConstructorUsedError;
  DateTime? get placedAt => throw _privateConstructorUsedError;

  /// Optional human-readable code for quick linking.
  String? get orderNumber => throw _privateConstructorUsedError;

  /// Create a copy of OrderRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderRefCopyWith<OrderRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderRefCopyWith<$Res> {
  factory $OrderRefCopyWith(OrderRef value, $Res Function(OrderRef) then) =
      _$OrderRefCopyWithImpl<$Res, OrderRef>;
  @useResult
  $Res call({
    String orderId,
    double? grandTotalSnapshot,
    String? currencyCode,
    OrderStatusSnapshot? statusSnapshot,
    DateTime? placedAt,
    String? orderNumber,
  });
}

/// @nodoc
class _$OrderRefCopyWithImpl<$Res, $Val extends OrderRef>
    implements $OrderRefCopyWith<$Res> {
  _$OrderRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? grandTotalSnapshot = freezed,
    Object? currencyCode = freezed,
    Object? statusSnapshot = freezed,
    Object? placedAt = freezed,
    Object? orderNumber = freezed,
  }) {
    return _then(
      _value.copyWith(
            orderId: null == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                      as String,
            grandTotalSnapshot: freezed == grandTotalSnapshot
                ? _value.grandTotalSnapshot
                : grandTotalSnapshot // ignore: cast_nullable_to_non_nullable
                      as double?,
            currencyCode: freezed == currencyCode
                ? _value.currencyCode
                : currencyCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            statusSnapshot: freezed == statusSnapshot
                ? _value.statusSnapshot
                : statusSnapshot // ignore: cast_nullable_to_non_nullable
                      as OrderStatusSnapshot?,
            placedAt: freezed == placedAt
                ? _value.placedAt
                : placedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            orderNumber: freezed == orderNumber
                ? _value.orderNumber
                : orderNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderRefImplCopyWith<$Res>
    implements $OrderRefCopyWith<$Res> {
  factory _$$OrderRefImplCopyWith(
    _$OrderRefImpl value,
    $Res Function(_$OrderRefImpl) then,
  ) = __$$OrderRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String orderId,
    double? grandTotalSnapshot,
    String? currencyCode,
    OrderStatusSnapshot? statusSnapshot,
    DateTime? placedAt,
    String? orderNumber,
  });
}

/// @nodoc
class __$$OrderRefImplCopyWithImpl<$Res>
    extends _$OrderRefCopyWithImpl<$Res, _$OrderRefImpl>
    implements _$$OrderRefImplCopyWith<$Res> {
  __$$OrderRefImplCopyWithImpl(
    _$OrderRefImpl _value,
    $Res Function(_$OrderRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? grandTotalSnapshot = freezed,
    Object? currencyCode = freezed,
    Object? statusSnapshot = freezed,
    Object? placedAt = freezed,
    Object? orderNumber = freezed,
  }) {
    return _then(
      _$OrderRefImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        grandTotalSnapshot: freezed == grandTotalSnapshot
            ? _value.grandTotalSnapshot
            : grandTotalSnapshot // ignore: cast_nullable_to_non_nullable
                  as double?,
        currencyCode: freezed == currencyCode
            ? _value.currencyCode
            : currencyCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        statusSnapshot: freezed == statusSnapshot
            ? _value.statusSnapshot
            : statusSnapshot // ignore: cast_nullable_to_non_nullable
                  as OrderStatusSnapshot?,
        placedAt: freezed == placedAt
            ? _value.placedAt
            : placedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        orderNumber: freezed == orderNumber
            ? _value.orderNumber
            : orderNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$OrderRefImpl implements _OrderRef {
  const _$OrderRefImpl({
    required this.orderId,
    this.grandTotalSnapshot,
    this.currencyCode,
    this.statusSnapshot,
    this.placedAt,
    this.orderNumber,
  });

  @override
  final String orderId;

  /// Minimal UI snapshot fields to avoid depending on Money in light refs.
  @override
  final double? grandTotalSnapshot;
  @override
  final String? currencyCode;
  @override
  final OrderStatusSnapshot? statusSnapshot;
  @override
  final DateTime? placedAt;

  /// Optional human-readable code for quick linking.
  @override
  final String? orderNumber;

  @override
  String toString() {
    return 'OrderRef(orderId: $orderId, grandTotalSnapshot: $grandTotalSnapshot, currencyCode: $currencyCode, statusSnapshot: $statusSnapshot, placedAt: $placedAt, orderNumber: $orderNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderRefImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.grandTotalSnapshot, grandTotalSnapshot) ||
                other.grandTotalSnapshot == grandTotalSnapshot) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.statusSnapshot, statusSnapshot) ||
                other.statusSnapshot == statusSnapshot) &&
            (identical(other.placedAt, placedAt) ||
                other.placedAt == placedAt) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    grandTotalSnapshot,
    currencyCode,
    statusSnapshot,
    placedAt,
    orderNumber,
  );

  /// Create a copy of OrderRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderRefImplCopyWith<_$OrderRefImpl> get copyWith =>
      __$$OrderRefImplCopyWithImpl<_$OrderRefImpl>(this, _$identity);
}

abstract class _OrderRef implements OrderRef {
  const factory _OrderRef({
    required final String orderId,
    final double? grandTotalSnapshot,
    final String? currencyCode,
    final OrderStatusSnapshot? statusSnapshot,
    final DateTime? placedAt,
    final String? orderNumber,
  }) = _$OrderRefImpl;

  @override
  String get orderId;

  /// Minimal UI snapshot fields to avoid depending on Money in light refs.
  @override
  double? get grandTotalSnapshot;
  @override
  String? get currencyCode;
  @override
  OrderStatusSnapshot? get statusSnapshot;
  @override
  DateTime? get placedAt;

  /// Optional human-readable code for quick linking.
  @override
  String? get orderNumber;

  /// Create a copy of OrderRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderRefImplCopyWith<_$OrderRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
