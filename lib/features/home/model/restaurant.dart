// features/home/model/restaurant.dart
import 'package:flutter/material.dart';

class Restaurant {
  final String name;
  final String id;
  final double rating;
  final int count;
  final List<String> tags;
  final String discount;
  final String discountType;
  final Color discountColor;
  final String imageUrl;
  final String type;
  final bool popular;
  final bool delivery;

  Restaurant({
    required this.name,
    required this.id,
    required this.rating,
    required this.count,
    required this.tags,
    required this.discount,
    required this.discountType,
    required this.discountColor,
    required this.imageUrl,
    required this.type,
    required this.popular,
    required this.delivery,
  });
}
