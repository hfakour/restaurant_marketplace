import '../repositories/reservation_repository.dart';

class ConfirmReservation {
  final ReservationRepository _repo;
  const ConfirmReservation(this._repo);

  Future<void> call(String reservationId, {DateTime? now}) =>
      _repo.confirm(reservationId, now: now);
}
