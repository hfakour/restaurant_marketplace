import 'dart:async';

import '../../../../core/domain_refs/reservation_ref.dart';
import '../entities/reservation.dart';            // for ReservationStatus
import '../repositories/reservation_repository.dart';
import '../value_objects/reservation_vos.dart';  // for UserId

class WatchUserReservationRefs {
  final ReservationRepository _repo;
  const WatchUserReservationRefs(this._repo);

  /// Live, lightweight stream for list UIs (raw String userId).
  Stream<List<ReservationRef>> call({
    required String userId,
    ReservationStatus? status,
  }) {
    return _repo.watchRefsForUser(userId: userId, status: status);
  }

  /// VO-friendly variant (preferred at the boundary).
  Stream<List<ReservationRef>> byVO({
    required UserId userId,
    ReservationStatus? status,
  }) {
    return _repo.watchRefsForUser(userId: userId.value, status: status);
  }
}
