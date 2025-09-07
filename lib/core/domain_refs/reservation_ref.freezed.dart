// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReservationRef {
  String get reservationId => throw _privateConstructorUsedError;
  String? get statusSnapshot => throw _privateConstructorUsedError;
  DateTime? get scheduledAt => throw _privateConstructorUsedError;
  String? get restaurantId => throw _privateConstructorUsedError;
  int? get partySize => throw _privateConstructorUsedError;

  /// Create a copy of ReservationRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationRefCopyWith<ReservationRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationRefCopyWith<$Res> {
  factory $ReservationRefCopyWith(
    ReservationRef value,
    $Res Function(ReservationRef) then,
  ) = _$ReservationRefCopyWithImpl<$Res, ReservationRef>;
  @useResult
  $Res call({
    String reservationId,
    String? statusSnapshot,
    DateTime? scheduledAt,
    String? restaurantId,
    int? partySize,
  });
}

/// @nodoc
class _$ReservationRefCopyWithImpl<$Res, $Val extends ReservationRef>
    implements $ReservationRefCopyWith<$Res> {
  _$ReservationRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReservationRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservationId = null,
    Object? statusSnapshot = freezed,
    Object? scheduledAt = freezed,
    Object? restaurantId = freezed,
    Object? partySize = freezed,
  }) {
    return _then(
      _value.copyWith(
            reservationId: null == reservationId
                ? _value.reservationId
                : reservationId // ignore: cast_nullable_to_non_nullable
                      as String,
            statusSnapshot: freezed == statusSnapshot
                ? _value.statusSnapshot
                : statusSnapshot // ignore: cast_nullable_to_non_nullable
                      as String?,
            scheduledAt: freezed == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            restaurantId: freezed == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                      as String?,
            partySize: freezed == partySize
                ? _value.partySize
                : partySize // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReservationRefImplCopyWith<$Res>
    implements $ReservationRefCopyWith<$Res> {
  factory _$$ReservationRefImplCopyWith(
    _$ReservationRefImpl value,
    $Res Function(_$ReservationRefImpl) then,
  ) = __$$ReservationRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String reservationId,
    String? statusSnapshot,
    DateTime? scheduledAt,
    String? restaurantId,
    int? partySize,
  });
}

/// @nodoc
class __$$ReservationRefImplCopyWithImpl<$Res>
    extends _$ReservationRefCopyWithImpl<$Res, _$ReservationRefImpl>
    implements _$$ReservationRefImplCopyWith<$Res> {
  __$$ReservationRefImplCopyWithImpl(
    _$ReservationRefImpl _value,
    $Res Function(_$ReservationRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReservationRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservationId = null,
    Object? statusSnapshot = freezed,
    Object? scheduledAt = freezed,
    Object? restaurantId = freezed,
    Object? partySize = freezed,
  }) {
    return _then(
      _$ReservationRefImpl(
        reservationId: null == reservationId
            ? _value.reservationId
            : reservationId // ignore: cast_nullable_to_non_nullable
                  as String,
        statusSnapshot: freezed == statusSnapshot
            ? _value.statusSnapshot
            : statusSnapshot // ignore: cast_nullable_to_non_nullable
                  as String?,
        scheduledAt: freezed == scheduledAt
            ? _value.scheduledAt
            : scheduledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        restaurantId: freezed == restaurantId
            ? _value.restaurantId
            : restaurantId // ignore: cast_nullable_to_non_nullable
                  as String?,
        partySize: freezed == partySize
            ? _value.partySize
            : partySize // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$ReservationRefImpl implements _ReservationRef {
  const _$ReservationRefImpl({
    required this.reservationId,
    this.statusSnapshot,
    this.scheduledAt,
    this.restaurantId,
    this.partySize,
  });

  @override
  final String reservationId;
  @override
  final String? statusSnapshot;
  @override
  final DateTime? scheduledAt;
  @override
  final String? restaurantId;
  @override
  final int? partySize;

  @override
  String toString() {
    return 'ReservationRef(reservationId: $reservationId, statusSnapshot: $statusSnapshot, scheduledAt: $scheduledAt, restaurantId: $restaurantId, partySize: $partySize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationRefImpl &&
            (identical(other.reservationId, reservationId) ||
                other.reservationId == reservationId) &&
            (identical(other.statusSnapshot, statusSnapshot) ||
                other.statusSnapshot == statusSnapshot) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.partySize, partySize) ||
                other.partySize == partySize));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    reservationId,
    statusSnapshot,
    scheduledAt,
    restaurantId,
    partySize,
  );

  /// Create a copy of ReservationRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationRefImplCopyWith<_$ReservationRefImpl> get copyWith =>
      __$$ReservationRefImplCopyWithImpl<_$ReservationRefImpl>(
        this,
        _$identity,
      );
}

abstract class _ReservationRef implements ReservationRef {
  const factory _ReservationRef({
    required final String reservationId,
    final String? statusSnapshot,
    final DateTime? scheduledAt,
    final String? restaurantId,
    final int? partySize,
  }) = _$ReservationRefImpl;

  @override
  String get reservationId;
  @override
  String? get statusSnapshot;
  @override
  DateTime? get scheduledAt;
  @override
  String? get restaurantId;
  @override
  int? get partySize;

  /// Create a copy of ReservationRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationRefImplCopyWith<_$ReservationRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
