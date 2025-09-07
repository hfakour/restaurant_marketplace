import '../repositories/reservation_repository.dart';

class CancelReservation {
  final ReservationRepository _repo;
  const CancelReservation(this._repo);

  Future<void> call(String reservationId, {DateTime? now}) =>
      _repo.cancel(reservationId, now: now);
}
