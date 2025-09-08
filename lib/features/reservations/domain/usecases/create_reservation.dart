import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';
import '../value_objects/reservation_vos.dart';
import '../value_objects/reservation_vo_adapters.dart';

class CreateReservation {
  final ReservationRepository _repo;
  const CreateReservation(this._repo);

  /// Path 1: pass a fully built domain entity (already VO-based).
  Future<String> call(Reservation reservation) {
    _validate(reservation);
    return _repo.create(reservation);
  }

  /// Path 2: build from Value Objects (recommended at boundary).
  Future<String> fromVOs({
    required ReservationId id,
    required UserId userId,
    required RestaurantId restaurantId,
    required UtcDateTime scheduledAt,
    required PartySize partySize,
    SpecialRequest? specialRequest,
    bool mustBeInFuture = false,
  }) {
    final entity = makeReservationFromVOs(
      id: id,
      userId: userId,
      restaurantId: restaurantId,
      scheduledAt: scheduledAt,
      partySize: partySize,
      specialRequest: specialRequest,
      mustBeInFuture: mustBeInFuture,
    );
    _validate(entity);
    return _repo.create(entity);
  }

  void _validate(Reservation r) {
    if (r.partySize.value <= 0) {
      throw ArgumentError.value(r.partySize.value, 'partySize', 'Must be > 0');
    }
    // Optional cross-field rule example:
    // if (!r.scheduledAt.value.isAfter(DateTime.now().toUtc())) {
    //   throw ArgumentError.value(r.scheduledAt.value, 'scheduledAt', 'Must be in the future');
    // }
  }
}
