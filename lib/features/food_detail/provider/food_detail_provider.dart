import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/food.dart';
import '../repository/food_repository.dart';
import '../viewmodel/food_detail_viewmodel.dart';

// Repository provider
final foodRepositoryProvider = Provider((ref) => FoodRepository());

// Food async data provider
final foodDetailProvider = FutureProvider.family<Food, String>((ref, id) {
  final repo = ref.watch(foodRepositoryProvider);
  return repo.fetchFoodById(id);
});

// StateNotifierProvider for ViewModel
final foodDetailViewModelProvider = StateNotifierProvider.autoDispose<FoodDetailViewModel, FoodDetailState>(
      (ref) => FoodDetailViewModel(),
);
