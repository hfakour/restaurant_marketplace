import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/menu_item.dart';
import '../repository/menu_repository.dart';

// Provide the repository
final menuRepositoryProvider = Provider((ref) => MenuRepository());

// Provide the menu list for a given restaurant
final menuProvider = FutureProvider.family<List<MenuItem>, String>((ref, restaurantId) {
  final repo = ref.watch(menuRepositoryProvider);
  return repo.fetchMenuForRestaurant(restaurantId);
});
