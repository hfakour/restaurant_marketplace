import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class CreateReservation {
  final ReservationRepository _repo;
  const CreateReservation(this._repo);

  Future<String> call(Reservation reservation) => _repo.create(reservation);
}
