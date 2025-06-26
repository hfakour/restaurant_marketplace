// features/home/data/mock_restaurants.dart
import 'package:flutter/material.dart';
import '../model/restaurant.dart';

const restaurantImgUrl =
    "https://www.starbaal.com/uploads/posts/dfdf5d.jpg?m=thumb&w=800&h=600&q=high";

final mockRestaurants = [
  Restaurant(
    id:"1",
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
    id:"2",
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
    id:"3",
    name: "Sakura Sushi",
    rating: 4.6,
    count: 140,
    tags: ["Japanese", "Seafood"],
    discount: "-10% OFF",
    discountType: "Delivery",
    discountColor: Colors.green,
    imageUrl: restaurantImgUrl,
    type: "delivery",
    popular: false,
    delivery: true,
  ),
  Restaurant(
    id:"4",
    name: "Le Croissant",
    rating: 4.9,
    count: 202,
    tags: ["Bakery", "Breakfast"],
    discount: "-25% OFF",
    discountType: "Dine In",
    discountColor: Colors.orange,
    imageUrl: restaurantImgUrl,
    type: "dinein",
    popular: true,
    delivery: false,
  ),
];
