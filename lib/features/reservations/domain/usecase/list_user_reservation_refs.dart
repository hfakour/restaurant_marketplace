import '../entities/refs/reservation_ref.dart';
import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class ListUserReservationRefs {
  final ReservationRepository _repo;
  const ListUserReservationRefs(this._repo);

  Future<ReservationRefPage> call({
    required String userId,
    ReservationStatus? status,
    int limit = 20,
    String? cursor,
  }) {
    return _repo.listRefsForUser(
      userId: userId,
      status: status,
      limit: limit,
      cursor: cursor,
    );
  }
}
