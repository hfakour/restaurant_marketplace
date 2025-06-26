// features/home/widgets/carousel_section/carousel_section.dart
import 'package:flutter/material.dart';

import '../../model/restaurant.dart';
import '../../viewmodel/filter_restaurants.dart';
import 'section_header.dart';
import 'premium_restaurant_card.dart';

class CarouselSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final RestaurantFilter filter;
  final List<Restaurant> restaurants;
  final void Function(Restaurant)? onRestaurantTap; // <-- Add this

  const CarouselSection({
    required this.title,
    required this.icon,
    required this.filter,
    required this.restaurants,
    this.onRestaurantTap, // <-- Add this
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = filterRestaurants(restaurants, filter);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title, icon: icon),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(width: 19),
            itemBuilder: (context, idx) {
              final restaurant = filtered[idx];
              return GestureDetector(
                onTap: onRestaurantTap == null ? null : () => onRestaurantTap!(restaurant),
                child: PremiumRestaurantCard(restaurant: restaurant),
              );
            },
          ),
        ),
      ],
    );
  }
}
