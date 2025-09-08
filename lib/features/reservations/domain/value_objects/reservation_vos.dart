import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_vos.freezed.dart';

/// ---------- ID VOs (type-safety over raw strings) ----------
@freezed
class ReservationId with _$ReservationId {
  const ReservationId._();
  const factory ReservationId({required String value}) = _ReservationId;
  factory ReservationId.create(String raw) {
    final v = raw.trim();
    if (v.isEmpty) throw ArgumentError('ReservationId cannot be empty');
    return ReservationId(value: v);
  }
  @override
  String toString() => value;
}

@freezed
class UserId with _$UserId {
  const UserId._();
  const factory UserId({required String value}) = _UserId;
  factory UserId.create(String raw) {
    final v = raw.trim();
    if (v.isEmpty) throw ArgumentError('UserId cannot be empty');
    return UserId(value: v);
  }
  @override
  String toString() => value;
}

@freezed
class RestaurantId with _$RestaurantId {
  const RestaurantId._();
  const factory RestaurantId({required String value}) = _RestaurantId;
  factory RestaurantId.create(String raw) {
    final v = raw.trim();
    if (v.isEmpty) throw ArgumentError('RestaurantId cannot be empty');
    return RestaurantId(value: v);
  }
  @override
  String toString() => value;
}

/// ---------- Booking VOs ----------
@freezed
class PartySize with _$PartySize {
  const PartySize._();
  const factory PartySize({required int value}) = _PartySize;

  /// Business rule: 1..20 (adjust to your needs)
  factory PartySize.create(int raw) {
    if (raw < 1) throw RangeError('PartySize must be >= 1');
    if (raw > 20) throw RangeError('PartySize must be <= 20');
    return PartySize(value: raw);
  }
}

@freezed
class SpecialRequest with _$SpecialRequest {
  const SpecialRequest._();
  const factory SpecialRequest({required String value}) = _SpecialRequest;

  /// Normalizes whitespace, caps length (e.g., 500)
  factory SpecialRequest.create(String? input, {int maxLen = 500}) {
    final v = (input ?? '').trim();
    if (v.length > maxLen) {
      throw ArgumentError('Special request exceeds $maxLen chars');
    }
    return SpecialRequest(value: v);
  }

  bool get isEmpty => value.isEmpty;
  String? get asNullable => isEmpty ? null : value;
}

/// Ensures DateTime is stored in UTC in the domain.
@freezed
class UtcDateTime with _$UtcDateTime {
  const UtcDateTime._();
  const factory UtcDateTime({required DateTime value}) = _UtcDateTime;

  factory UtcDateTime.create(DateTime dt) =>
      UtcDateTime(value: dt.isUtc ? dt : dt.toUtc());
}
