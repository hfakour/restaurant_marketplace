import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class WatchReservationsForRestaurantParams {
  final String restaurantId;
  final DateTime? start;
  final DateTime? end;
  final ReservationStatus? status;

  const WatchReservationsForRestaurantParams({
    required this.restaurantId,
    this.start,
    this.end,
    this.status,
  });
}

class WatchReservationsForRestaurant {
  final ReservationRepository _repo;
  const WatchReservationsForRestaurant(this._repo);

  Stream<List<Reservation>> call(WatchReservationsForRestaurantParams p) =>
      _repo.watchForRestaurant(
        restaurantId: p.restaurantId,
        start: p.start,
        end: p.end,
        status: p.status,
      );
}
