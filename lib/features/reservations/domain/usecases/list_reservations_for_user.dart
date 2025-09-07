import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class ListReservationsForUserParams {
  final String userId;
  final ReservationStatus? status;
  final int limit;
  final String? cursor;

  const ListReservationsForUserParams({
    required this.userId,
    this.status,
    this.limit = 50,
    this.cursor,
  });
}

class ListReservationsForUser {
  final ReservationRepository _repo;
  const ListReservationsForUser(this._repo);

  Future<ReservationSearchPage> call(ListReservationsForUserParams p) =>
      _repo.listForUser(
        userId: p.userId,
        status: p.status,
        limit: p.limit,
        cursor: p.cursor,
      );
}
