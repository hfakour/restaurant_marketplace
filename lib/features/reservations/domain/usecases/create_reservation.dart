import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

// Optional VO helpers – keep if you use VOs; otherwise remove these two lines.
import '../value_objects/reservation_vos.dart';
import '../value_objects/reservation_vo_adapters.dart';

class CreateReservation {
  final ReservationRepository _repo;
  const CreateReservation(this._repo);

  /// Path 1: pass a fully built domain entity
  Future<String> call(Reservation reservation) {
    _validateEntity(reservation);
    return _repo.create(reservation);
  }

  /// Path 2: build from Value Objects (if you’re using them)
  Future<String> fromVOs({
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
    );
    _validateEntity(entity);
    return _repo.create(entity);
  }

  // ------ local private validator (this is the missing method) ------
  void _validateEntity(Reservation r) {
    if (r.partySize <= 0) {
      throw ArgumentError.value(r.partySize, 'partySize', 'Must be > 0');
    }
    // Optional: enforce future times
    // if (r.scheduledAt.isBefore(DateTime.now())) {
    //   throw ArgumentError.value(r.scheduledAt, 'scheduledAt', 'Must be in the future');
    // }
  }
}
