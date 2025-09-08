import '../../../../core/domain_refs/reservation_ref.dart';
import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class ListUserReservationRefs {
  final ReservationRepository _repo;
  const ListUserReservationRefs(this._repo);

  /// Paged list of lightweight refs for a user's list screen.
  /// Pass back the returned nextCursor to fetch subsequent pages.
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
