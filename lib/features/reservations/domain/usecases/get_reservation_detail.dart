import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class GetReservationDetail {
  final ReservationRepository _repo;
  const GetReservationDetail(this._repo);

  /// Fetches the full Reservation for a details screen.
  Future<Reservation?> call(String reservationId) {
    return _repo.getById(reservationId);
  }
}
