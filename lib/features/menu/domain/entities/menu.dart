// domain/entities/menu.dart
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../food/domain/entities/refs/food_ref.dart';

part 'menu.freezed.dart';

@freezed
class Menu with _$Menu {
  const factory Menu({
    required String id,

    // Ownership
    required String restaurantId,

    // Identity
    required String title,
    String? description,

    // Media
    String? coverUrl,
    @Default(<String>[]) List<String> galleryUrls,

    // Composition (lightweight relation to foods via refs)
    @Default(<FoodRef>[]) List<FoodRef> foodRefs,

    // Status
    @Default(true) bool isActive,

    // Auditing
    DateTime? createdAt,
    DateTime? updatedAt,

    // Extra metadata (safe by design)
    @Default(<String, dynamic>{}) Map<String, dynamic> metadata,
  }) = _Menu;
}
