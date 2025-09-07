import '../repositories/reservation_repository.dart';

class MarkNoShow {
  final ReservationRepository _repo;
  const MarkNoShow(this._repo);

  Future<void> call(String reservationId, {DateTime? now}) =>
      _repo.markNoShow(reservationId, now: now);
}
