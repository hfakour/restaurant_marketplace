import '../entities/favorite.dart';
import '../repositories/favorite_repository.dart';

class CreateFavorite {
  final FavoriteRepository _repo;
  const CreateFavorite(this._repo);

  Future<String> call(Favorite favorite) => _repo.create(favorite);
}
