import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_marketplace/features/home/model/restaurant.dart';
import 'package:restaurant_marketplace/features/home/viewmodel/filter_restaurants.dart';


void main() {
  const restaurantImgUrl =
      "https://www.starbaal.com/uploads/posts/dfdf5d.jpg?m=thumb&w=800&h=600&q=high";

  final mockRestaurants = [
    Restaurant(
      id: "1",
      name: "Saffron Palace",
      rating: 4.8,
      count: 180,
      tags: ["Persian", "Fine Dining"],
      discount: "-30% OFF",
      discountType: "Dining In",
      discountColor: Colors.pink,
      imageUrl: restaurantImgUrl,
      type: "dinein",
      popular: true,
      delivery: true,
    ),
    Restaurant(
      id: "2",
      name: "Golden Fish Grill",
      rating: 4.7,
      count: 156,
      tags: ["Seafood", "Delivery"],
      discount: "-15% OFF",
      discountType: "Delivery",
      discountColor: Colors.blue,
      imageUrl: restaurantImgUrl,
      type: "delivery",
      popular: true,
      delivery: true,
    ),
    Restaurant(
      id: "3",
      name: "Sakura Sushi",
      rating: 4.6,
      count: 140,
      tags: ["Japanese", "Seafood"],
      discount: "-20% OFF",
      discountType: "Delivery",
      discountColor: Colors.green,
      imageUrl: restaurantImgUrl,
      type: "dinein",
      popular: false,
      delivery: false,
    ),
  ];

  group('filterRestaurants', () {
    test('filters by delivery', () {
      final result = filterRestaurants(mockRestaurants, RestaurantFilter.delivery);
      expect(result.length, 2);
      expect(result.every((r) => r.delivery), isTrue);
    });

    test('filters by dinein', () {
      final result = filterRestaurants(mockRestaurants, RestaurantFilter.dinein);
      expect(result.length, 2);
      expect(result.every((r) => r.type == "dinein"), isTrue);
    });

    test('filters by popular', () {
      final result = filterRestaurants(mockRestaurants, RestaurantFilter.popular);
      expect(result.length, 2);
      expect(result.every((r) => r.popular), isTrue);
    });

    test('returns all for RestaurantFilter.all', () {
      final result = filterRestaurants(mockRestaurants, RestaurantFilter.all);
      expect(result.length, mockRestaurants.length);
    });
  });
}
