// domain/repositories/reservation_repository.dart
import '../entities/reservation.dart';

/// Contract for reading/writing reservations.
abstract class ReservationRepository {
  /// Get by ID.
  Future<Reservation?> getById(String id);

  /// List reservations for a user (newest first).
  Future<ReservationSearchPage> listForUser({
    required String userId,
    ReservationStatus? status, // optional filter
    int limit = 50,
    String? cursor, // opaque numeric offset for in-memory impls
  });

  /// List reservations for a restaurant within a time window (inclusive).
  Future<ReservationSearchPage> listForRestaurant({
    required String restaurantId,
    DateTime? start, // if null -> all past/future
    DateTime? end,   // if null -> all past/future
    ReservationStatus? status,
    int limit = 50,
    String? cursor,
  });

  /// Live updates for a user's reservations.
  Stream<List<Reservation>> watchForUser({
    required String userId,
    ReservationStatus? status,
  });

  /// Live updates for a restaurant's reservations within a time window.
  Stream<List<Reservation>> watchForRestaurant({
    required String restaurantId,
    DateTime? start,
    DateTime? end,
    ReservationStatus? status,
  });

  /// Create a reservation. Returns its ID (caller may pre-generate).
  Future<String> create(Reservation reservation);

  /// Update all mutable fields (reschedule, partySize, specialRequest, etc.).
  Future<void> update(Reservation reservation);

  /// Update only the status.
  Future<void> updateStatus(String reservationId, ReservationStatus status, {DateTime? now});

  /// Convenience helpers.
  Future<void> confirm(String reservationId, {DateTime? now});
  Future<void> cancel(String reservationId, {DateTime? now});
  Future<void> complete(String reservationId, {DateTime? now});
  Future<void> markNoShow(String reservationId, {DateTime? now});

  /// Very basic conflict lookup:
  /// same restaurant and scheduledAt matching exactly (you can extend to ranges).
  Future<List<Reservation>> findExactConflicts({
    required String restaurantId,
    required DateTime scheduledAt,
  });
}

/// Simple page container.
class ReservationSearchPage {
  final List<Reservation> items;
  final String? nextCursor;
  const ReservationSearchPage({required this.items, this.nextCursor});
}
