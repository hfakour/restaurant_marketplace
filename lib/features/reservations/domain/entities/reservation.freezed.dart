// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Reservation {
  ReservationId get id => throw _privateConstructorUsedError;
  UserId get userId => throw _privateConstructorUsedError;
  RestaurantId get restaurantId => throw _privateConstructorUsedError;
  UtcDateTime get scheduledAt => throw _privateConstructorUsedError;
  PartySize get partySize => throw _privateConstructorUsedError;
  SpecialRequest? get specialRequest => throw _privateConstructorUsedError;
  ReservationStatus get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationCopyWith<Reservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationCopyWith<$Res> {
  factory $ReservationCopyWith(
    Reservation value,
    $Res Function(Reservation) then,
  ) = _$ReservationCopyWithImpl<$Res, Reservation>;
  @useResult
  $Res call({
    ReservationId id,
    UserId userId,
    RestaurantId restaurantId,
    UtcDateTime scheduledAt,
    PartySize partySize,
    SpecialRequest? specialRequest,
    ReservationStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  $ReservationIdCopyWith<$Res> get id;
  $UserIdCopyWith<$Res> get userId;
  $RestaurantIdCopyWith<$Res> get restaurantId;
  $UtcDateTimeCopyWith<$Res> get scheduledAt;
  $PartySizeCopyWith<$Res> get partySize;
  $SpecialRequestCopyWith<$Res>? get specialRequest;
}

/// @nodoc
class _$ReservationCopyWithImpl<$Res, $Val extends Reservation>
    implements $ReservationCopyWith<$Res> {
  _$ReservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? restaurantId = null,
    Object? scheduledAt = null,
    Object? partySize = null,
    Object? specialRequest = freezed,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as ReservationId,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as UserId,
            restaurantId: null == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                      as RestaurantId,
            scheduledAt: null == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
                      as UtcDateTime,
            partySize: null == partySize
                ? _value.partySize
                : partySize // ignore: cast_nullable_to_non_nullable
                      as PartySize,
            specialRequest: freezed == specialRequest
                ? _value.specialRequest
                : specialRequest // ignore: cast_nullable_to_non_nullable
                      as SpecialRequest?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ReservationStatus,
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

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReservationIdCopyWith<$Res> get id {
    return $ReservationIdCopyWith<$Res>(_value.id, (value) {
      return _then(_value.copyWith(id: value) as $Val);
    });
  }

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserIdCopyWith<$Res> get userId {
    return $UserIdCopyWith<$Res>(_value.userId, (value) {
      return _then(_value.copyWith(userId: value) as $Val);
    });
  }

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RestaurantIdCopyWith<$Res> get restaurantId {
    return $RestaurantIdCopyWith<$Res>(_value.restaurantId, (value) {
      return _then(_value.copyWith(restaurantId: value) as $Val);
    });
  }

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UtcDateTimeCopyWith<$Res> get scheduledAt {
    return $UtcDateTimeCopyWith<$Res>(_value.scheduledAt, (value) {
      return _then(_value.copyWith(scheduledAt: value) as $Val);
    });
  }

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PartySizeCopyWith<$Res> get partySize {
    return $PartySizeCopyWith<$Res>(_value.partySize, (value) {
      return _then(_value.copyWith(partySize: value) as $Val);
    });
  }

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpecialRequestCopyWith<$Res>? get specialRequest {
    if (_value.specialRequest == null) {
      return null;
    }

    return $SpecialRequestCopyWith<$Res>(_value.specialRequest!, (value) {
      return _then(_value.copyWith(specialRequest: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReservationImplCopyWith<$Res>
    implements $ReservationCopyWith<$Res> {
  factory _$$ReservationImplCopyWith(
    _$ReservationImpl value,
    $Res Function(_$ReservationImpl) then,
  ) = __$$ReservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ReservationId id,
    UserId userId,
    RestaurantId restaurantId,
    UtcDateTime scheduledAt,
    PartySize partySize,
    SpecialRequest? specialRequest,
    ReservationStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  @override
  $ReservationIdCopyWith<$Res> get id;
  @override
  $UserIdCopyWith<$Res> get userId;
  @override
  $RestaurantIdCopyWith<$Res> get restaurantId;
  @override
  $UtcDateTimeCopyWith<$Res> get scheduledAt;
  @override
  $PartySizeCopyWith<$Res> get partySize;
  @override
  $SpecialRequestCopyWith<$Res>? get specialRequest;
}

/// @nodoc
class __$$ReservationImplCopyWithImpl<$Res>
    extends _$ReservationCopyWithImpl<$Res, _$ReservationImpl>
    implements _$$ReservationImplCopyWith<$Res> {
  __$$ReservationImplCopyWithImpl(
    _$ReservationImpl _value,
    $Res Function(_$ReservationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? restaurantId = null,
    Object? scheduledAt = null,
    Object? partySize = null,
    Object? specialRequest = freezed,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ReservationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as ReservationId,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as UserId,
        restaurantId: null == restaurantId
            ? _value.restaurantId
            : restaurantId // ignore: cast_nullable_to_non_nullable
                  as RestaurantId,
        scheduledAt: null == scheduledAt
            ? _value.scheduledAt
            : scheduledAt // ignore: cast_nullable_to_non_nullable
                  as UtcDateTime,
        partySize: null == partySize
            ? _value.partySize
            : partySize // ignore: cast_nullable_to_non_nullable
                  as PartySize,
        specialRequest: freezed == specialRequest
            ? _value.specialRequest
            : specialRequest // ignore: cast_nullable_to_non_nullable
                  as SpecialRequest?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ReservationStatus,
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

class _$ReservationImpl extends _Reservation {
  const _$ReservationImpl({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.scheduledAt,
    required this.partySize,
    this.specialRequest,
    this.status = ReservationStatus.pending,
    this.createdAt,
    this.updatedAt,
  }) : super._();

  @override
  final ReservationId id;
  @override
  final UserId userId;
  @override
  final RestaurantId restaurantId;
  @override
  final UtcDateTime scheduledAt;
  @override
  final PartySize partySize;
  @override
  final SpecialRequest? specialRequest;
  @override
  @JsonKey()
  final ReservationStatus status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Reservation(id: $id, userId: $userId, restaurantId: $restaurantId, scheduledAt: $scheduledAt, partySize: $partySize, specialRequest: $specialRequest, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.partySize, partySize) ||
                other.partySize == partySize) &&
            (identical(other.specialRequest, specialRequest) ||
                other.specialRequest == specialRequest) &&
            (identical(other.status, status) || other.status == status) &&
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
    restaurantId,
    scheduledAt,
    partySize,
    specialRequest,
    status,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      __$$ReservationImplCopyWithImpl<_$ReservationImpl>(this, _$identity);
}

abstract class _Reservation extends Reservation {
  const factory _Reservation({
    required final ReservationId id,
    required final UserId userId,
    required final RestaurantId restaurantId,
    required final UtcDateTime scheduledAt,
    required final PartySize partySize,
    final SpecialRequest? specialRequest,
    final ReservationStatus status,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$ReservationImpl;
  const _Reservation._() : super._();

  @override
  ReservationId get id;
  @override
  UserId get userId;
  @override
  RestaurantId get restaurantId;
  @override
  UtcDateTime get scheduledAt;
  @override
  PartySize get partySize;
  @override
  SpecialRequest? get specialRequest;
  @override
  ReservationStatus get status;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
