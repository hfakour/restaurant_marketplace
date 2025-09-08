import '../repositories/reservation_repository.dart';

class CancelReservation {
  final ReservationRepository _repo;
  const CancelReservation(this._repo);

  /// Cancels a reservation.
  /// Repository updates entity.status and the ReservationRef snapshot.
  Future<void> call(String reservationId) {
    return _repo.cancel(reservationId);
  }
}
