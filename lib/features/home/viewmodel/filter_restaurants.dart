// features/home/viewmodel/filter_restaurants.dart
import '../model/restaurant.dart';

enum RestaurantFilter { delivery, dinein, popular, all }

List<Restaurant> filterRestaurants(
    List<Restaurant> restaurants,
    RestaurantFilter filter,
    ) {
  switch (filter) {
    case RestaurantFilter.delivery:
      return restaurants.where((r) => r.delivery).toList();
    case RestaurantFilter.dinein:
      return restaurants.where((r) => r.type == "dinein").toList();
    case RestaurantFilter.popular:
      return restaurants.where((r) => r.popular).toList();
    case RestaurantFilter.all:
    default:
      return restaurants;
  }
}
