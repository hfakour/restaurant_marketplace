import '../entities/reservation.dart';
import 'reservation_vos.dart';

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
}) {
  return Reservation(
    id: id.value,
    userId: userId.value,
    restaurantId: restaurantId.value,
    scheduledAt: scheduledAt.value,
    partySize: partySize.value,
    specialRequest: specialRequest?.asNullable,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
