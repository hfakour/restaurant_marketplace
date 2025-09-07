import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class UpdateReservationStatusParams {
  final String reservationId;
  final ReservationStatus status;
  final DateTime? now;

  const UpdateReservationStatusParams({
    required this.reservationId,
    required this.status,
    this.now,
  });
}

class UpdateReservationStatus {
  final ReservationRepository _repo;
  const UpdateReservationStatus(this._repo);

  Future<void> call(UpdateReservationStatusParams p) =>
      _repo.updateStatus(p.reservationId, p.status, now: p.now);
}
