import '../entities/favorite.dart';
import '../repositories/favorite_repository.dart';

class DeactivateFavoriteByTargetParams {
  final String userId;
  final FavoriteTargetType targetType;
  final String targetId;

  const DeactivateFavoriteByTargetParams({
    required this.userId,
    required this.targetType,
    required this.targetId,
  });
}

class DeactivateFavoriteByTarget {
  final FavoriteRepository _repo;
  const DeactivateFavoriteByTarget(this._repo);

  Future<void> call(DeactivateFavoriteByTargetParams p) =>
      _repo.deactivateByTarget(
        userId: p.userId,
        targetType: p.targetType,
        targetId: p.targetId,
      );
}
