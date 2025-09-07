// domain/entities/favorite.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite.freezed.dart';

/// What a user can favorite.
enum FavoriteTargetType { product, vendor, category, service, content }

@freezed
class Favorite with _$Favorite {
  const factory Favorite({
    required String id,
    required String userId,

    required FavoriteTargetType targetType,
    required String targetId,         // ID of the product/vendor/etc.

    /// Optional snapshots for quick UI (avoid heavy joins).
    String? titleSnapshot,
    String? imageUrlSnapshot,
    String? vendorIdSnapshot,

    /// Enables soft-delete without data loss.
    @Default(true) bool isActive,

    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Favorite;
}
