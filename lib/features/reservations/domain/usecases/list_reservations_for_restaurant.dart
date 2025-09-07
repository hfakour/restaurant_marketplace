import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class ListReservationsForRestaurantParams {
  final String restaurantId;
  final DateTime? start;
  final DateTime? end;
  final ReservationStatus? status;
  final int limit;
  final String? cursor;

  const ListReservationsForRestaurantParams({
    required this.restaurantId,
    this.start,
    this.end,
    this.status,
    this.limit = 50,
    this.cursor,
  });
}

class ListReservationsForRestaurant {
  final ReservationRepository _repo;
  const ListReservationsForRestaurant(this._repo);

  Future<ReservationSearchPage> call(ListReservationsForRestaurantParams p) =>
      _repo.listForRestaurant(
        restaurantId: p.restaurantId,
        start: p.start,
        end: p.end,
        status: p.status,
        limit: p.limit,
        cursor: p.cursor,
      );
}
