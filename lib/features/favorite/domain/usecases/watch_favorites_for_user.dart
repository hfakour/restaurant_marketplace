import '../entities/favorite.dart';
import '../repositories/favorite_repository.dart';

class WatchFavoritesForUserParams {
  final String userId;
  final FavoriteTargetType? targetType;
  final bool onlyActive;

  const WatchFavoritesForUserParams({
    required this.userId,
    this.targetType,
    this.onlyActive = true,
  });
}

class WatchFavoritesForUser {
  final FavoriteRepository _repo;
  const WatchFavoritesForUser(this._repo);

  Stream<List<Favorite>> call(WatchFavoritesForUserParams p) =>
      _repo.watchForUser(
        userId: p.userId,
        targetType: p.targetType,
        onlyActive: p.onlyActive,
      );
}
