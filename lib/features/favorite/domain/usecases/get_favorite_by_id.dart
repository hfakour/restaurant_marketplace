import '../entities/favorite.dart';
import '../repositories/favorite_repository.dart';

class GetFavoriteById {
  final FavoriteRepository _repo;
  const GetFavoriteById(this._repo);

  Future<Favorite?> call(String id) => _repo.getById(id);
}
