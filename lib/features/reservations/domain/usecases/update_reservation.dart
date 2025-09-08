import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';
import '../value_objects/reservation_vos.dart';
import '../value_objects/reservation_vo_adapters.dart';

class UpdateReservation {
  final ReservationRepository _repo;
  const UpdateReservation(this._repo);

  Future<void> call(Reservation reservation) {
    _validate(reservation);
    return _repo.update(reservation);
  }

  /// Optional VO-friendly path if you rebuild the entity at the boundary.
  Future<void> fromVOs({
    required ReservationId id,
    required UserId userId,
    required RestaurantId restaurantId,
    required UtcDateTime scheduledAt,
    required PartySize partySize,
    SpecialRequest? specialRequest,
  }) {
    final entity = makeReservationFromVOs(
      id: id,
      userId: userId,
      restaurantId: restaurantId,
      scheduledAt: scheduledAt,
      partySize: partySize,
      specialRequest: specialRequest,
      // status/createdAt/updatedAt can be set by repo/DS as needed
    );
    _validate(entity);
    return _repo.update(entity);
  }

  void _validate(Reservation r) {
    if (r.partySize.value <= 0) {
      throw ArgumentError.value(r.partySize.value, 'partySize', 'Must be > 0');
    }
  }
}
