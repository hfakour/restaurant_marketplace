import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/food_repository.dart';
import '../model/food.dart';

import '../data/food_mock_data.dart';
import '../viewmodel/food_detail_state.dart';
import '../viewmodel/food_detail_viewmodel.dart';

// Provide the mock repository
final foodRepositoryProvider = Provider<IFoodRepository>(
      (ref) => MockFoodRepository(mockFoods),
);

// Provide food detail async loader by id
final foodDetailProvider = FutureProvider.family<Food, String>((ref, id) {
  final repo = ref.watch(foodRepositoryProvider);
  return repo.fetchFoodById(id);
});

// Provide the customizations state
final foodDetailViewModelProvider =
StateNotifierProvider<FoodDetailViewModel, FoodDetailState>(
      (ref) => FoodDetailViewModel(),
);
