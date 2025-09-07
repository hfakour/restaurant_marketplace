import '../repositories/reservation_repository.dart';

class CompleteReservation {
  final ReservationRepository _repo;
  const CompleteReservation(this._repo);

  Future<void> call(String reservationId, {DateTime? now}) =>
      _repo.complete(reservationId, now: now);
}

