import '../model/food.dart';
import '../data/food_mock_data.dart';

class FoodRepository {
  Future<Food> fetchFoodById(String id) async {
    // Simulate fetching data with a delay
    await Future.delayed(const Duration(milliseconds: 300));
    return mockFood; // Use mock data here!
  }
}
