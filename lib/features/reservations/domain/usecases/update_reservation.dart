import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class UpdateReservation {
  final ReservationRepository _repo;
  const UpdateReservation(this._repo);

  Future<void> call(Reservation reservation) {
    _validateEntity(reservation);
    return _repo.update(reservation);
  }

  void _validateEntity(Reservation r) {
    if (r.partySize <= 0) {
      throw ArgumentError.value(r.partySize, 'partySize', 'Must be > 0');
    }
  }
}
