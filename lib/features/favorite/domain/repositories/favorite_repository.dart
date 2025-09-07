// domain/repositories/favorite_repository.dart
import '../entities/favorite.dart';

/// Contract for reading/writing user favorites.
/// Keep this interface framework-agnostic and side-effect free.
abstract class FavoriteRepository {
  /// Returns the favorite by ID, or null if missing.
  Future<Favorite?> getById(String id);

  /// Quick check to see if a specific target is favorited by this user.
  Future<bool> isFavorited({
    required String userId,
    required FavoriteTargetType targetType,
    required String targetId,
    bool onlyActive = true,
  });

  /// Paginated list of favorites for a user, optionally filtered by [targetType].
  /// Use the returned [nextCursor] to fetch the next page.
  Future<FavoriteSearchPage> listForUser({
    required String userId,
    FavoriteTargetType? targetType,
    bool onlyActive = true,
    int limit = 50,
    String? cursor,
  });

  /// Live updates for a user's favorites (optionally by type).
  Stream<List<Favorite>> watchForUser({
    required String userId,
    FavoriteTargetType? targetType,
    bool onlyActive = true,
  });

  /// Create a new favorite. Returns the assigned ID (caller can pre-generate).
  Future<String> create(Favorite favorite);

  /// Update mutable fields (e.g., snapshots, isActive).
  Future<void> update(Favorite favorite);

  /// Soft delete: sets isActive = false and updates updatedAt.
  Future<void> deactivate(String favoriteId);

  /// Soft delete by composite user+target (convenience).
  Future<void> deactivateByTarget({
    required String userId,
    required FavoriteTargetType targetType,
    required String targetId,
  });

  /// Toggle favorite on/off for (user, targetType, targetId).
  /// If a record exists, flips [isActive] and updates [updatedAt].
  /// If no record exists, creates an active Favorite using provided snapshots.
  /// Returns the new state (true = active/favorited).
  Future<bool> toggle({
    required String userId,
    required FavoriteTargetType targetType,
    required String targetId,
    String? titleSnapshot,
    String? imageUrlSnapshot,
    String? vendorIdSnapshot,
    DateTime? now,
  });
}

/// Cursor page for favorites.
class FavoriteSearchPage {
  final List<Favorite> items;
  final String? nextCursor;
  const FavoriteSearchPage({required this.items, this.nextCursor});
}
