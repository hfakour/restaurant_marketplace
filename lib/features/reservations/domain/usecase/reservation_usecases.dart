import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';
import '../entities/refs/reservation_ref.dart';

class ReservationUsecases {
  final ReservationRepository _repo;
  ReservationUsecases(this._repo);

  Future<Reservation?> getDetail(String id) => _repo.getById(id);

  Future<ReservationRefPage> listRefs({
    required String userId,
    ReservationStatus? status,
    int limit = 20,
    String? cursor,
  }) =>
      _repo.listRefsForUser(
        userId: userId,
        status: status,
        limit: limit,
        cursor: cursor,
      );

  Stream<List<ReservationRef>> watchRefs({
    required String userId,
    ReservationStatus? status,
  }) =>
      _repo.watchRefsForUser(userId: userId, status: status);

  Future<String> create(Reservation r) {
    _validate(r);
    return _repo.create(r);
  }

  Future<void> update(Reservation r) {
    _validate(r);
    return _repo.update(r);
  }

  Future<void> cancel(String id) => _repo.cancel(id);

  void _validate(Reservation r) {
    if (r.partySize.value <= 0) {
      throw ArgumentError.value(r.partySize.value, 'partySize', 'Must be > 0');
    }
  }
}
