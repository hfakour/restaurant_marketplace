import 'package:flutter/material.dart';
import '../../food_detail/widgets/section_title.dart';
import 'top_restaurant_card.dart';

class TopRestaurantsSection extends StatelessWidget {
  final List<Map<String, dynamic>> restaurants;
  const TopRestaurantsSection({required this.restaurants, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SectionTitle('Top Restaurants'),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: restaurants
                .map((r) => TopRestaurantCard(data: r))
                .toList(),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
