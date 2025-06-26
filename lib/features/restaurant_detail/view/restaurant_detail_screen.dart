import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../menu/view/menu_screen.dart';
import '../../reservation/view/reservation.screen.dart';
import '../viewmodel/restaurant_detail_viewmodel.dart';

// --- COLOR PALETTE ---
const bgColor = Color(0xFFF8F4EF);
const cardBg = Colors.white;
const charcoal = Color(0xFF232325);
const subtleGray = Color(0xFFEEEEEE);

class RestaurantDetailScreen extends ConsumerWidget {
  final String restaurantId;

  const RestaurantDetailScreen({required this.restaurantId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantAsync = ref.watch(restaurantDetailProvider(restaurantId));
    final textTheme = Theme.of(context).textTheme;

    return restaurantAsync.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (restaurant) {
        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: charcoal,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 22,
              ),
              onPressed: () => Navigator.of(context).maybePop(),
              tooltip: 'Back',
            ),
            titleSpacing: 0,
            title: Text(
              restaurant.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontFamily: 'Georgia',
                fontSize: 22,
                letterSpacing: -1,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {},
                tooltip: 'Add to Favorites',
              ),
            ],
          ),

          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header image
                        ClipRRect(
                          borderRadius: BorderRadius.zero,
                          child: Image.network(
                            restaurant.imageUrl,
                            height: 260,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) => Container(
                                  height: 260,
                                  color: subtleGray,
                                  child: const Icon(
                                    Icons.restaurant,
                                    size: 44,
                                    color: charcoal,
                                  ),
                                ),
                            semanticLabel: "${restaurant.name} header image",
                          ),
                        ),
                        // Main content
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                          decoration: const BoxDecoration(
                            color: cardBg,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, -2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // --- Name, Location Button, perfectly centered ---
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      restaurant.name,
                                      style: textTheme.titleLarge?.copyWith(
                                        fontFamily: 'Georgia',
                                        fontWeight: FontWeight.w800,
                                        color: charcoal,
                                        fontSize: 21.5,
                                        letterSpacing: -0.5,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.location_pin,
                                      color: charcoal,
                                      size: 23,
                                    ),
                                    onPressed: () {},
                                    tooltip: 'Show on Map',
                                    padding: const EdgeInsets.only(bottom: 1),
                                  ),
                                ],
                              ),
                              // --- Tags ---
                              if (restaurant.tags.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Wrap(
                                    spacing: 9,
                                    children:
                                        restaurant.tags
                                            .map(
                                              (tag) => Chip(
                                                label: Text(
                                                  tag,
                                                  style: const TextStyle(
                                                    color: charcoal,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Georgia',
                                                    fontSize: 13.2,
                                                  ),
                                                ),
                                                backgroundColor: subtleGray,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 5,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                  ),
                                ),
                              // --- Description ---
                              Text(
                                restaurant.description,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontSize: 15.3,
                                  height: 1.48,
                                  fontFamily: 'Georgia',
                                  color: charcoal,
                                ),
                              ),
                              const SizedBox(height: 15),
                              // --- Chef Section ---
                              Text(
                                'Meet the Chef',
                                style: textTheme.titleMedium?.copyWith(
                                  fontFamily: 'Georgia',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.4,
                                ),
                              ),
                              const SizedBox(height: 9),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                      restaurant.chefImage,
                                    ),
                                    backgroundColor: subtleGray,
                                  ),
                                  const SizedBox(width: 13),
                                  Expanded(
                                    child: Text(
                                      restaurant.chefDescription,
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontFamily: 'Georgia',
                                        fontSize: 14.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              // --- Gallery ---
                              Text(
                                'Gallery',
                                style: textTheme.titleMedium?.copyWith(
                                  fontFamily: 'Georgia',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.4,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 104,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: restaurant.galleryImages.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                        right:
                                            index ==
                                                    restaurant
                                                            .galleryImages
                                                            .length -
                                                        1
                                                ? 0
                                                : 12,
                                      ),
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            restaurant.galleryImages[index],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 12),
                              // --- Opening Hours ---
                              Text(
                                'Opening Hours',
                                style: textTheme.titleMedium?.copyWith(
                                  fontFamily: 'Georgia',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.2,
                                ),
                              ),
                              const SizedBox(height: 7),
                              const Text(
                                'Currently: Open',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Georgia',
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                restaurant.hours,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontFamily: 'Georgia',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Available for: Dine-In • Takeaway • Delivery',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: charcoal,
                                  fontFamily: 'Georgia',
                                  fontSize: 14.5,
                                ),
                              ),
                              const SizedBox(height: 15),
                              // --- Menu Highlights ---
                              Text(
                                'Menu Highlights',
                                style: textTheme.titleMedium?.copyWith(
                                  fontFamily: 'Georgia',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.2,
                                ),
                              ),
                              const SizedBox(height: 13),
                              ...restaurant.menu
                                  .take(3)
                                  .map(
                                    (menuItem) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 13,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Icon (vertically centered)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 2.0,
                                            ),
                                            child: const Icon(
                                              Icons.restaurant_menu,
                                              color: charcoal,
                                              size: 22,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          // Name & Description
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  menuItem.name,
                                                  style: textTheme.titleSmall
                                                      ?.copyWith(
                                                        fontFamily: 'Georgia',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.7,
                                                        color: charcoal,
                                                      ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  menuItem.description,
                                                  style: textTheme.bodySmall
                                                      ?.copyWith(
                                                        fontSize: 13.5,
                                                        color: charcoal
                                                            .withValues(
                                                              alpha: 0.7,
                                                            ),
                                                        fontFamily: 'Georgia',
                                                      ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Price, always vertically centered
                                          const SizedBox(width: 14),
                                          ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              minWidth: 70,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '\$${menuItem.price}',
                                                  style: textTheme.titleMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: charcoal,
                                                        fontFamily: 'Georgia',
                                                        fontSize: 17,
                                                      ),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              const SizedBox(height: 12),

                              // --- Reviews ---
                              Text(
                                'Customer Reviews',
                                style: textTheme.titleMedium?.copyWith(
                                  fontFamily: 'Georgia',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.2,
                                ),
                              ),
                              const SizedBox(height: 13),
                              ...restaurant.reviews.map(
                                (r) => _ReviewTile(
                                  name: r.name,
                                  comment: r.comment,
                                  rating: r.rating,
                                ),
                              ),
                              const SizedBox(height: 90),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Bottom action bar
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: cardBg,
                  padding: const EdgeInsets.fromLTRB(16, 13, 16, 25),
                  child: Row(
                    children: [
                      // Reserve a Table button WITH ICON
                      Expanded(
                        flex: 8,
                        child: SizedBox(
                          height: 53,
                          child: FilledButton.icon(
                            icon: const Icon(
                              Icons.table_bar,
                              size: 22,
                              color: Colors.white,
                            ),
                            label: const Text('Reserve a Table'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ReservationScreen(restaurantName: restaurant.name),
                                ),
                              );
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: charcoal,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 15.7,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Georgia',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      // View Full Menu button
                      Expanded(
                        flex: 8,
                        child: SizedBox(
                          height: 53,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => MenuScreen(
                                        restaurantId: restaurant.id,
                                      ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.menu_book,
                              color: charcoal,
                              size: 20,
                            ),
                            label: const Text(
                              'View Full Menu',
                              style: TextStyle(
                                color: charcoal,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.7,
                                fontFamily: 'Georgia',
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: charcoal,
                                width: 1.4,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              backgroundColor: cardBg,
                              foregroundColor: charcoal,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Georgia',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// --- Customer Review Tile ---
class _ReviewTile extends StatelessWidget {
  final String name;
  final String comment;
  final double rating;

  const _ReviewTile({
    required this.name,
    required this.comment,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: subtleGray,
            child: Text(
              name[0],
              style: const TextStyle(
                color: charcoal,
                fontWeight: FontWeight.bold,
                fontFamily: 'Georgia',
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Georgia',
                    fontSize: 14.5,
                  ),
                ),
                const SizedBox(height: 3),
                RatingBarIndicator(
                  rating: rating,
                  itemBuilder:
                      (context, index) =>
                          const Icon(Icons.star, color: Colors.amber),
                  itemSize: 17,
                ),
                const SizedBox(height: 4),
                Text(
                  comment,
                  style: const TextStyle(
                    fontSize: 13.2,
                    fontFamily: 'Georgia',
                    color: charcoal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
