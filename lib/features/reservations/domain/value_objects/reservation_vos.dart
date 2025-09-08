// domain/value_objects/reservation_vos.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_vos.freezed.dart';

/// (Optional) Common ID rules you may want to enforce
class IdRules {
  // Example ULID pattern (uppercase Crockford base32, len 26)
  static final RegExp ulid = RegExp(r'^[0-9A-HJKMNP-TV-Z]{26}$');
}

/// ---------- ID VOs ----------
@freezed
class ReservationId with _$ReservationId {
  const ReservationId._();
  const factory ReservationId({required String value}) = _ReservationId;

  factory ReservationId.create(String raw, {RegExp? pattern}) {
    final v = raw.trim();
    if (v.isEmpty) throw ArgumentError('ReservationId cannot be empty');
    if (pattern != null && !pattern.hasMatch(v)) {
      throw ArgumentError('ReservationId does not match required pattern');
    }
    return ReservationId(value: v);
  }

  /// Safe constructor that returns null instead of throwing.
  static ReservationId? tryCreate(String raw, {RegExp? pattern}) {
    try { return ReservationId.create(raw, pattern: pattern); } catch (_) { return null; }
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

  static UserId? tryCreate(String raw) {
    try { return UserId.create(raw); } catch (_) { return null; }
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

  static RestaurantId? tryCreate(String raw) {
    try { return RestaurantId.create(raw); } catch (_) { return null; }
  }

  @override
  String toString() => value;
}

/// ---------- Booking VOs ----------
@freezed
class PartySize with _$PartySize {
  const PartySize._();
  const factory PartySize({required int value}) = _PartySize;

  static const int min = 1;
  static const int max = 20; // tweak per business

  factory PartySize.create(int raw) {
    if (raw < min) throw RangeError('PartySize must be >= $min');
    if (raw > max) throw RangeError('PartySize must be <= $max');
    return PartySize(value: raw);
  }

  /// If you prefer not to throw, clamp into range.
  factory PartySize.clamped(int raw) {
    final v = raw.clamp(min, max);
    return PartySize(value: v);
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

  factory UtcDateTime.now() => UtcDateTime(value: DateTime.now().toUtc());
}
