import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';
import '../value_objects/reservation_vos.dart';

class GetReservationDetail {
  final ReservationRepository _repo;
  const GetReservationDetail(this._repo);

  Future<Reservation?> call(String reservationId) => _repo.getById(reservationId);

  Future<Reservation?> byVO(ReservationId id) => _repo.getById(id.value);
}
