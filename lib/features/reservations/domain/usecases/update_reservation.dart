import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class UpdateReservation {
  final ReservationRepository _repo;
  const UpdateReservation(this._repo);

  Future<void> call(Reservation reservation) => _repo.update(reservation);
}
