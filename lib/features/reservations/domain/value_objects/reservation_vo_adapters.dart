// domain/value_objects/reservation_vo_adapters.dart
import '../entities/reservation.dart';
import 'reservation_vos.dart';

typedef Now = DateTime Function();

/// Build a Reservation entity from VOs (non-breaking integration).
Reservation makeReservationFromVOs({
  required ReservationId id,
  required UserId userId,
  required RestaurantId restaurantId,
  required UtcDateTime scheduledAt,
  required PartySize partySize,
  SpecialRequest? specialRequest,
  ReservationStatus status = ReservationStatus.pending,
  DateTime? createdAt,
  DateTime? updatedAt,

  /// Optional: provide a clock & require future scheduling
  Now nowUtc = _defaultNowUtc,
  bool mustBeInFuture = false,
}) {
  final now = nowUtc().toUtc();
  if (mustBeInFuture && !scheduledAt.value.isAfter(now)) {
    throw ArgumentError('scheduledAt must be in the future');
  }

  return Reservation(
    id: id,
    userId: userId,
    restaurantId: restaurantId,
    scheduledAt: scheduledAt,
    partySize: partySize,
    specialRequest: specialRequest,
    status: status,
    createdAt: createdAt ?? now,
    updatedAt: updatedAt ?? now,
  );
}

DateTime _defaultNowUtc() => DateTime.now().toUtc();
