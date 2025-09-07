import '../repositories/favorite_repository.dart';

class DeactivateFavorite {
  final FavoriteRepository _repo;
  const DeactivateFavorite(this._repo);

  Future<void> call(String favoriteId) => _repo.deactivate(favoriteId);
}
