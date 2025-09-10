import '../repositories/reservation_repository.dart';
import '../value_objects/reservation_vos.dart';

class CancelReservation {
  final ReservationRepository _repo;
  const CancelReservation(this._repo);

  /// Cancels by raw id.
  Future<void> call(String reservationId) => _repo.cancel(reservationId);

  /// Cancels by VO (preferred at boundary).
  Future<void> byVO(ReservationId id) => _repo.cancel(id.value);
}
