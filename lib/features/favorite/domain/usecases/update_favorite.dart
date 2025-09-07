import '../entities/favorite.dart';
import '../repositories/favorite_repository.dart';

class UpdateFavorite {
  final FavoriteRepository _repo;
  const UpdateFavorite(this._repo);

  Future<void> call(Favorite favorite) => _repo.update(favorite);
}
