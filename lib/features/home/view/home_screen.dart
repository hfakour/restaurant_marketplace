import 'package:flutter/material.dart';

import '../../../core/theme/home_styles.dart';
import '../../restaurant_detail/view/restaurant_detail_screen.dart';
import '../data/mock_restaurants.dart';
import '../viewmodel/filter_restaurants.dart';
import '../widgets/carousel_section/carousel_section.dart';
import '../widgets/category_carousel/category_carousel.dart';
import '../widgets/search_bar.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/overlap_card.dart';
import '../model/restaurant.dart'; // <-- Make sure you import your Restaurant model

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // DRY: define a single navigation function to use for all carousels
    void onRestaurantTap(Restaurant restaurant) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => RestaurantDetailScreen(restaurantId: restaurant.id),
        ),
      );
    }

    return Scaffold(
      backgroundColor: HomeStyles.bgColor,
      appBar: const HomeAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const HomeSearchBar(),
              Container(
                height: HomeStyles.categoryCardHeight,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 24, left: 8, right: 8),
                child: const CategoryCarousel(),
              ),
              // Use the new OverlapCard here:
              Expanded(
                child: OverlapCard(
                  topOverlap: 25.0,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      CarouselSection(
                        title: "Fast Delivery",
                        icon: Icons.delivery_dining,
                        filter: RestaurantFilter.delivery,
                        restaurants: mockRestaurants,
                        onRestaurantTap: onRestaurantTap,
                      ),
                      const SizedBox(height: HomeStyles.carouselSectionSpacing),
                      CarouselSection(
                        title: "Best Dining In",
                        icon: Icons.restaurant,
                        filter: RestaurantFilter.dinein,
                        restaurants: mockRestaurants,
                        onRestaurantTap: onRestaurantTap,
                      ),
                      const SizedBox(height: HomeStyles.carouselSectionSpacing),
                      CarouselSection(
                        title: "Most Popular",
                        icon: Icons.star,
                        filter: RestaurantFilter.popular,
                        restaurants: mockRestaurants,
                        onRestaurantTap: onRestaurantTap,
                      ),
                      const SizedBox(height: HomeStyles.carouselSectionSpacing),
                      CarouselSection(
                        title: "24 Hours",
                        icon: Icons.nightlife,
                        filter: RestaurantFilter.all,
                        restaurants: mockRestaurants,
                        onRestaurantTap: onRestaurantTap,
                      ),
                      const SizedBox(height: HomeStyles.carouselSectionSpacing),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
