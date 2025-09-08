// domain/repositories/reservation_repository.dart
import '../../../../core/domain_refs/reservation_ref.dart';
import '../entities/reservation.dart';

/// Contract for reading/writing reservations for CLIENT app.
abstract class ReservationRepository {
  // ----- Reads -----

  /// Full entity by ID (details screen).
  Future<Reservation?> getById(String id);

  /// Lightweight page of user's reservations (for lists).
  Future<ReservationRefPage> listRefsForUser({
    required String userId,
    ReservationStatus? status, // optional filter
    int limit = 50,
    String? cursor, // opaque paging token
  });

  /// Full page when you explicitly need entities (e.g., exporting).
  Future<ReservationSearchPage> listForUser({
    required String userId,
    ReservationStatus? status,
    int limit = 50,
    String? cursor,
  });

  /// Live lightweight updates for user's list UIs.
  Stream<List<ReservationRef>> watchRefsForUser({
    required String userId,
    ReservationStatus? status,
  });

  /// Live full entities (detail screens / deep observers).
  Stream<List<Reservation>> watchForUser({
    required String userId,
    ReservationStatus? status,
  });

  // ----- Writes -----

  /// Create a reservation. Returns its ID.
  ///
  /// Implementations MUST also upsert the corresponding ReservationRef
  /// into the user's ref collection so lists update immediately.
  Future<String> create(Reservation reservation);

  /// Update mutable fields (reschedule, partySize, specialRequest, etc.).
  ///
  /// Implementations MUST also refresh the user's ReservationRef snapshot.
  Future<void> update(Reservation reservation);

  /// Client action that we keep: cancel.
  ///
  /// (Admin-only actions like confirm/complete/noShow were removed.)
  Future<void> cancel(String reservationId, {DateTime? now});
}

/// Page container for full entities (kept for completeness).
class ReservationSearchPage {
  final List<Reservation> items;
  final String? nextCursor;
  const ReservationSearchPage({required this.items, this.nextCursor});
}

/// Page container for lightweight refs (used by list screens).
class ReservationRefPage {
  final List<ReservationRef> items;
  final String? nextCursor;
  const ReservationRefPage({required this.items, this.nextCursor});
}
