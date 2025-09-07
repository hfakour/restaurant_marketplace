import '../entities/favorite.dart';
import '../repositories/favorite_repository.dart';

class IsFavoritedParams {
  final String userId;
  final FavoriteTargetType targetType;
  final String targetId;
  final bool onlyActive;
  const IsFavoritedParams({
    required this.userId,
    required this.targetType,
    required this.targetId,
    this.onlyActive = true,
  });
}

class IsFavorited {
  final FavoriteRepository _repo;
  const IsFavorited(this._repo);

  Future<bool> call(IsFavoritedParams p) => _repo.isFavorited(
    userId: p.userId,
    targetType: p.targetType,
    targetId: p.targetId,
    onlyActive: p.onlyActive,
  );
}
