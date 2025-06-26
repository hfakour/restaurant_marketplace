import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/restaurant.dart';
import '../repository/restaurant_repository.dart';

final restaurantRepositoryProvider = Provider((ref) => RestaurantRepository());

final restaurantDetailProvider = FutureProvider.family<Restaurant, String>((ref, id) {
  final repo = ref.watch(restaurantRepositoryProvider);
  return repo.fetchRestaurantById(id);
});
