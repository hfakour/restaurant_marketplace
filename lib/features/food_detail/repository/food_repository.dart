import '../model/food.dart';

abstract class IFoodRepository {
  Future<Food> fetchFoodById(String id);
}

class MockFoodRepository implements IFoodRepository {
  final List<Food> _mockFoods;
  MockFoodRepository(this._mockFoods);

  @override
  Future<Food> fetchFoodById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockFoods.firstWhere((f) => f.id == id, orElse: () => throw Exception('Not found'));
  }
}
