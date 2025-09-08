import 'dart:async';

import '../../../../core/domain_refs/reservation_ref.dart';
import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class WatchUserReservationRefs {
  final ReservationRepository _repo;
  const WatchUserReservationRefs(this._repo);

  /// Live, lightweight stream for list UIs.
  Stream<List<ReservationRef>> call({
    required String userId,
    ReservationStatus? status,
  }) {
    return _repo.watchRefsForUser(userId: userId, status: status);
  }
}
