import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class GetReservationById {
  final ReservationRepository _repo;
  const GetReservationById(this._repo);

  Future<Reservation?> call(String id) => _repo.getById(id);
}
