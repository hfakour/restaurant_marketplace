import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class FindExactConflictsParams {
  final String restaurantId;
  final DateTime scheduledAt;

  const FindExactConflictsParams({
    required this.restaurantId,
    required this.scheduledAt,
  });
}

class FindExactConflicts {
  final ReservationRepository _repo;
  const FindExactConflicts(this._repo);

  Future<List<Reservation>> call(FindExactConflictsParams p) =>
      _repo.findExactConflicts(
        restaurantId: p.restaurantId,
        scheduledAt: p.scheduledAt,
      );
}
