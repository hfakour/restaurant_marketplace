import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../food_detail/view/food_detail_screen.dart';
import '../../menu/view/menu_screen.dart';
import '../viewmodel/restaurant_detail_viewmodel.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String restaurantId;
  const RestaurantDetailScreen({required this.restaurantId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantAsync = ref.watch(restaurantDetailProvider(restaurantId));

    return restaurantAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (restaurant) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: Text(restaurant.name, style: const TextStyle(color: Colors.white)),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header image
                    Image.network(
                      restaurant.imageUrl,
                      height: 280,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    // Main content
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, -4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Restaurant name and location
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                restaurant.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.location_pin, color: Colors.black),
                                onPressed: () {
                                  // TODO: add map logic if needed
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Tags
                          Wrap(
                            spacing: 8,
                            children: restaurant.tags
                                .map((tag) => Chip(
                              label: Text(tag),
                              backgroundColor: Colors.brown.shade50,
                            ))
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                          // Description
                          Text(
                            restaurant.description,
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),
                          const SizedBox(height: 16),
                          // Chef info
                          const Text('Meet the Chef',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(restaurant.chefImage),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  restaurant.chefDescription,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Gallery
                          const Text('Gallery',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurant.galleryImages.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  width: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(restaurant.galleryImages[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Opening hours
                          const Text('Opening Hours',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Text('Currently: Open', style: TextStyle(color: Colors.green)),
                          const SizedBox(height: 4),
                          Text(restaurant.hours),
                          const SizedBox(height: 4),
                          const Text('Available for: Dine-In • Takeaway • Delivery'),
                          const SizedBox(height: 20),
                          // Menu highlights (show top 3, link to FoodDetail)
                          const Text('Menu Highlights',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          ...restaurant.menu.take(3).map((menuItem) => ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 4),
                            leading: const Icon(Icons.restaurant_menu, color: Colors.brown),
                            title: Text(menuItem.name,
                                style: const TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text(menuItem.description),
                            trailing: Text('\$${menuItem.price}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FoodDetailScreen(foodId: menuItem.id),
                                ),
                              );
                            },
                          )),
                          const SizedBox(height: 8),
                          // Reviews
                          const Text('Customer Reviews',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          ...restaurant.reviews.map(
                                  (r) => _buildReview(r.name, r.comment, r.rating)),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom action bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 5, 16, 25),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Reserve logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4AF37),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Reserve a Table',
                              style: TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // View Full Menu as a TextButton
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MenuScreen(restaurantId: restaurant.id),
                            ),
                          );
                        },
                        icon: const Icon(Icons.menu_book, color: Color(0xFFD4AF37)),
                        label: const Text('View Full Menu',
                            style: TextStyle(
                                color: Color(0xFFD4AF37),
                                fontWeight: FontWeight.bold)),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 12),
                          foregroundColor: const Color(0xFFD4AF37),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static Widget _buildReview(String name, String comment, double rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.brown.shade100,
            child: Text(name[0], style: const TextStyle(color: Colors.brown)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                RatingBarIndicator(
                  rating: rating,
                  itemBuilder: (context, index) =>
                  const Icon(Icons.star, color: Colors.amber),
                  itemSize: 16,
                ),
                const SizedBox(height: 4),
                Text(comment),
              ],
            ),
          )
        ],
      ),
    );
  }
}
