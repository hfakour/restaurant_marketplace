import 'package:flutter/material.dart';
import '../data/food_mock_data.dart';
import '../widgets/category_carousel.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/restaurant_carousel_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EF),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Good evening, Hassan 👋',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 18, 20, 2),
                child: HomeSearchBar(),
              ),
              const SizedBox(height: 10),
              // Main Categories Carousel
              const CategoryCarousel(),

              // Discount Restaurants Carousel
              RestaurantCarouselSection(
                title: "Discount Restaurants",
                restaurants: kDiscountRestaurants,
              ),
              // Top Dining-In Carousel
              RestaurantCarouselSection(
                title: "Top Dining-In",
                restaurants: kTopDiningIn,
              ),
              // Top Delivery Carousel
              RestaurantCarouselSection(
                title: "Top Delivery",
                restaurants: kTopDelivery,
              ),
              // Fastest Delivery Carousel
              RestaurantCarouselSection(
                title: "Fastest Delivery",
                restaurants: kFastestDelivery,
              ),

              // Vertical Top Restaurants Section (optional)
              // TopRestaurantsSection(restaurants: kTopDiningIn),
            ],
          ),
        ),
      ),
    );
  }
}
