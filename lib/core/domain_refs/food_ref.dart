import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_ref.freezed.dart';

@freezed
class FoodRef with _$FoodRef {
  const factory FoodRef({
    required String foodId,
    String? nameSnapshot,         // e.g., "Margherita Pizza"
    int? priceCentsSnapshot,      // lightweight price display
    String? imageUrlSnapshot,     // thumbnail image
    @Default(true) bool isAvailable,
  }) = _FoodRef;
}
