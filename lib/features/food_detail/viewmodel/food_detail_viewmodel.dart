import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodDetailState {
  final int quantity;
  final String selectedSize;
  final bool extraCheese;
  FoodDetailState({
    this.quantity = 1,
    this.selectedSize = 'Regular',
    this.extraCheese = false,
  });

  FoodDetailState copyWith({
    int? quantity,
    String? selectedSize,
    bool? extraCheese,
  }) {
    return FoodDetailState(
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      extraCheese: extraCheese ?? this.extraCheese,
    );
  }
}

class FoodDetailViewModel extends StateNotifier<FoodDetailState> {
  FoodDetailViewModel() : super(FoodDetailState());

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
