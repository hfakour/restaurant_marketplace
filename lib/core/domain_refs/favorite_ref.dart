// domain/entities/favorite_ref.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_ref.freezed.dart';

@freezed
class FavoriteRef with _$FavoriteRef {
  const factory FavoriteRef({
    required String favoriteId,
    String? targetIdSnapshot,
    String? titleSnapshot,
    String? imageUrlSnapshot,
    @Default(true) bool isActive,
  }) = _FavoriteRef;
}
