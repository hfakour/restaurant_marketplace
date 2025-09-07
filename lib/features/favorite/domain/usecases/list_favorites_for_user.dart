import '../entities/favorite.dart';
import '../repositories/favorite_repository.dart';

class ListFavoritesForUserParams {
  final String userId;
  final FavoriteTargetType? targetType;
  final bool onlyActive;
  final int limit;
  final String? cursor;

  const ListFavoritesForUserParams({
    required this.userId,
    this.targetType,
    this.onlyActive = true,
    this.limit = 50,
    this.cursor,
  });
}

class ListFavoritesForUser {
  final FavoriteRepository _repo;
  const ListFavoritesForUser(this._repo);

  Future<FavoriteSearchPage> call(ListFavoritesForUserParams p) =>
      _repo.listForUser(
        userId: p.userId,
        targetType: p.targetType,
        onlyActive: p.onlyActive,
        limit: p.limit,
        cursor: p.cursor,
      );
}
