// domain/repositories/reservation_repository.dart
import '../entities/refs/reservation_ref.dart';
import '../entities/reservation.dart';

/// Client-facing contract for reservations.
/// Optimized for lightweight list UIs + detail fetch on demand.
abstract class ReservationRepository {
  // ----- Reads -----

  /// Load a full reservation by ID (details screen).
  Future<Reservation?> getById(String id);

  /// Paged, lightweight list of a user's reservations.
  /// Filtering is by [status] only, which matches the app's UX.
  Future<ReservationRefPage> listRefsForUser({
    required String userId,
    ReservationStatus? status, // optional filter for simple search
    int limit = 10,
    String? cursor, // opaque paging token (offset, doc anchor, etc.)
  });

  /// Live, lightweight updates for user's list UIs.
  /// Emits the full current set for the applied filter.
  Stream<List<ReservationRef>> watchRefsForUser({
    required String userId,
    ReservationStatus? status, // filter matches listRefsForUser
  });

  // ----- Writes -----

  /// Create a reservation. Returns its generated ID.
  ///
  /// Implementations MUST:
  ///  - persist the full Reservation
  ///  - upsert its ReservationRef snapshot for the user (entities -> ref)
  Future<String> create(Reservation reservation);

  /// Update user-editable fields (time, partySize, specialRequest, etc.).
  ///
  /// Implementations MUST refresh the corresponding ReservationRef snapshot.
  Future<void> update(Reservation reservation);

  /// Cancel a reservation (client action).
  ///
  /// Implementations MUST set entities.status = cancelled AND
  /// update the ReservationRef.statusSnapshot accordingly.
  Future<void> cancel(String reservationId, {DateTime? now});
}

/// Page container for lightweight refs (used by list screens).
class ReservationRefPage {
  final List<ReservationRef> items;
  final String? nextCursor;
  const ReservationRefPage({required this.items, this.nextCursor});
}
