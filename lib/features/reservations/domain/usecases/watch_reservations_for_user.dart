import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class WatchReservationsForUserParams {
  final String userId;
  final ReservationStatus? status;

  const WatchReservationsForUserParams({
    required this.userId,
    this.status,
  });
}

class WatchReservationsForUser {
  final ReservationRepository _repo;
  const WatchReservationsForUser(this._repo);

  Stream<List<Reservation>> call(WatchReservationsForUserParams p) =>
      _repo.watchForUser(userId: p.userId, status: p.status);
}
