import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'food_detail_state.dart';

class FoodDetailViewModel extends StateNotifier<FoodDetailState> {
  FoodDetailViewModel() : super(const FoodDetailState());

  void changeQuantity(int delta) {
    final newQuantity = (state.quantity + delta).clamp(1, 99);
    state = state.copyWith(quantity: newQuantity);
  }

  void changeSize(String size) {
    state = state.copyWith(selectedSize: size);
  }

  void toggleExtraCheese() {
    state = state.copyWith(extraCheese: !state.extraCheese);
  }
}
