import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_detail_state.freezed.dart';

@freezed
class FoodDetailState with _$FoodDetailState {
  const factory FoodDetailState({
    @Default(1) int quantity,
    @Default('Regular') String selectedSize,
    @Default(false) bool extraCheese,
  }) = _FoodDetailState;
}
