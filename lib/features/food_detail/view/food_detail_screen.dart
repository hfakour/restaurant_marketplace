import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../restaurant_detail/view/restaurant_detail_screen.dart';
import '../provider/food_detail_provider.dart';
import '../widgets/add_to_cart_button.dart';
import '../widgets/food_image_banner.dart';
import '../widgets/vendor_info_row.dart';
import '../widgets/details_card.dart'; // <--- NEW

class FoodDetailScreen extends ConsumerWidget {
  final String foodId;
  const FoodDetailScreen({required this.foodId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodAsync = ref.watch(foodDetailProvider(foodId));
    final state = ref.watch(foodDetailViewModelProvider);
    final viewModel = ref.read(foodDetailViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Deluxe Cuisine'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: foodAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Failed to load food: $e')),
        data: (food) {
          final double unitPrice =
              food.originalPrice * (1 - food.discountPercentage / 100) +
                  (state.extraCheese ? 1 : 0);

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 96),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FoodImageBanner(imageUrl: food.imageUrl),
                    VendorInfoRow(
                      vendorImage: food.vendor.image,
                      vendorName: food.vendor.name,
                      vendorLocation: food.vendor.location,
                      rating: food.rating,
                      reviewsCount: food.reviewsCount,
                      onViewRestaurant: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RestaurantDetailScreen(
                              restaurantId: food.restaurantId, // Use correct id property!
                            ),
                          ),
                        );
                      },
                    ),
                    DetailsCard(
                      food: food,
                      state: state,
                      viewModel: viewModel,
                    ),
                  ],
                ),
              ),
              // Sticky button
              Positioned(
                left: 0,
                right: 0,
                bottom: -25,
                child: SafeArea(
                  minimum: const EdgeInsets.all(0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.07),
                          blurRadius: 20,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 25, top: 16,
                    ),
                    child: AddToCartButton(unitPrice: unitPrice),
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
