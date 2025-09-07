import '../entities/favorite.dart';
import '../repositories/favorite_repository.dart';

class ToggleFavoriteParams {
  final String userId;
  final FavoriteTargetType targetType;
  final String targetId;
  final String? titleSnapshot;
  final String? imageUrlSnapshot;
  final String? vendorIdSnapshot;
  final DateTime? now;

  const ToggleFavoriteParams({
    required this.userId,
    required this.targetType,
    required this.targetId,
    this.titleSnapshot,
    this.imageUrlSnapshot,
    this.vendorIdSnapshot,
    this.now,
  });
}

class ToggleFavorite {
  final FavoriteRepository _repo;
  const ToggleFavorite(this._repo);

  /// Returns true if the item is favorited after the toggle.
  Future<bool> call(ToggleFavoriteParams p) => _repo.toggle(
    userId: p.userId,
    targetType: p.targetType,
    targetId: p.targetId,
    titleSnapshot: p.titleSnapshot,
    imageUrlSnapshot: p.imageUrlSnapshot,
    vendorIdSnapshot: p.vendorIdSnapshot,
    now: p.now,
  );
}
