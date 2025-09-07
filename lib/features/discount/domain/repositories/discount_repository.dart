// domain/repositories/discount_repository.dart

import '../entities/discount.dart';

/// Read/write access for Discount aggregates with a minimal surface
/// tailored for your flows (listing, lookups, limits, toggling).
///
/// Notes:
/// - "now" is an injectable clock to keep this repository deterministic
///   in tests (validity windows, etc.).
/// - "cursor" is an opaque pagination token returned by the impl.
abstract class DiscountRepository {
  /// Fetch by ID. Returns null if not found or inactive (when [onlyActive] is true).
  Future<Discount?> getById(
      String id, {
        bool onlyActive = false,
        DateTime? now,
      });

  /// Fetch by (case-insensitive) code, preferring active + date-valid records.
  Future<Discount?> getByCode(
      String code, {
        bool onlyActive = true,
        DateTime? now,
      });

  /// Paginated search with common filters.
  /// Provide an incoming [cursor] to continue where the previous page ended.
  Future<DiscountSearchPage> search({
    bool onlyActive = true,
    DateTime? now,
    int limit = 20,
    String? cursor,
  });

  /// Watch active discounts for a specific user (e.g., personalized or saved).
  Stream<List<Discount>> watchActiveForUser(
      String userId, {
        DateTime? now,
      });

  /// Create a discount. Returns the generated ID.
  Future<String> create(Discount discount);

  /// Update a discount (id must exist).
  Future<void> update(Discount discount);

  /// Soft-disable (isActive = false). Safe default instead of deleting.
  Future<void> deactivate(String discountId);

  /// Attempts to atomically reserve/record one redemption for [userId].
  /// Implementations should enforce:
  ///   - endsAt / startsAt window
  ///   - isActive flag
  ///   - maxGlobalRedemptions
  ///   - maxPerUser
  /// Returns true if reservation succeeded, false otherwise.
  Future<bool> tryConsumeRedemption({
    required String discountId,
    required String userId,
    DateTime? now,
  });
}

/// A single page of discounts with an opaque cursor for the next page.
class DiscountSearchPage {
  final List<Discount> items;
  final String? nextCursor;

  const DiscountSearchPage({required this.items, this.nextCursor});
}
