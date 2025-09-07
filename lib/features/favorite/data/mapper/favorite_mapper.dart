import '../../domain/entities/favorite.dart';
import '../model/favorite_model.dart';

FavoriteTargetType _targetFromString(String s) {
  return FavoriteTargetType.values.firstWhere(
        (e) => e.name == s,
    orElse: () => FavoriteTargetType.product,
  );
}

extension FavoriteModelX on FavoriteModel {
  Favorite toDomain() {
    return Favorite(
      id: id,
      userId: userId,
      targetType: _targetFromString(targetType),
      targetId: targetId,
      titleSnapshot: titleSnapshot,
      imageUrlSnapshot: imageUrlSnapshot,
      vendorIdSnapshot: vendorIdSnapshot,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension FavoriteDomainX on Favorite {
  FavoriteModel toModel() {
    return FavoriteModel(
      id: id,
      userId: userId,
      targetType: targetType.name,
      targetId: targetId,
      titleSnapshot: titleSnapshot,
      imageUrlSnapshot: imageUrlSnapshot,
      vendorIdSnapshot: vendorIdSnapshot,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
