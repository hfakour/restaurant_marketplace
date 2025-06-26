import 'package:flutter/material.dart';

// ----- MOCK MODELS -----
class FavoriteRestaurant {
  final String name;
  final String imageUrl;
  final double rating;
  final String cuisine;
  final DateTime addedAt;

  FavoriteRestaurant({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.cuisine,
    required this.addedAt,
  });
}

class FavoriteFood {
  final String name;
  final String restaurant;
  final String imageUrl;
  final List<String> tags;
  final double rating;
  final DateTime addedAt;

  FavoriteFood({
    required this.name,
    required this.restaurant,
    required this.imageUrl,
    this.tags = const [],
    required this.rating,
    required this.addedAt,
  });
}

// ----- MOCK DATA -----
final mockFavoriteRestaurants = [
  FavoriteRestaurant(
    name: "Tokyo Bowl",
    imageUrl: "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
    rating: 4.7,
    cuisine: "Japanese",
    addedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  FavoriteRestaurant(
    name: "Urban Grill",
    imageUrl: "https://images.unsplash.com/photo-1550547660-d9450f859349",
    rating: 4.8,
    cuisine: "BBQ & Grill",
    addedAt: DateTime.now().subtract(const Duration(days: 7)),
  ),
];

final mockFavoriteFoods = [
  FavoriteFood(
    name: 'Spicy Ramen',
    restaurant: 'Tokyo Bowl',
    imageUrl: 'https://images.unsplash.com/photo-1464306076886-debca5e8a6b0',
    tags: ['Noodles', 'Spicy'],
    rating: 4.8,
    addedAt: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  FavoriteFood(
    name: 'BBQ Beef Burger',
    restaurant: 'Urban Grill',
    imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349',
    tags: ['Burger', 'BBQ'],
    rating: 4.7,
    addedAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
  ),
];

// ----- COLORS -----
const Color kAmber = Colors.amber;
const Color kBrown = Color(0xFF8D6748);

// ----- MAIN FAVORITE SCREEN -----
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: _CustomTabBar(),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: TabBarView(
            children: [
              _FavoriteFoodsTab(),
              _FavoriteRestaurantsTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomTabBar extends StatelessWidget {
  const _CustomTabBar();

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 4.0,
          color: kAmber,
        ),
        insets: EdgeInsets.symmetric(horizontal: 28.0), // tighter or wider line
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: kAmber,
      unselectedLabelColor: kBrown,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      tabs: const [
        _BrownAmberTab(icon: Icons.fastfood, text: "Food"),
        _BrownAmberTab(icon: Icons.store_mall_directory, text: "Restaurant"),
      ],
    );
  }
}

class _BrownAmberTab extends StatelessWidget {
  final IconData icon;
  final String text;
  const _BrownAmberTab({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final TabController? tabController = DefaultTabController.of(context);
    final int tabIndex = (text == "Food") ? 0 : 1;
    return AnimatedBuilder(
      animation: tabController ?? AlwaysStoppedAnimation(0),
      builder: (context, _) {
        final isSelected = tabController?.index == tabIndex;
        return Tab(
          icon: Icon(
            icon,
            color: isSelected ? kAmber : kBrown,
          ),
          text: text,
        );
      },
    );
  }
}

// ----- FOODS TAB -----
class _FavoriteFoodsTab extends StatelessWidget {
  const _FavoriteFoodsTab();

  @override
  Widget build(BuildContext context) {
    if (mockFavoriteFoods.isEmpty) {
      return const _EmptySectionMessage(message: "No favorite foods yet.");
    }
    return ListView.separated(
      itemCount: mockFavoriteFoods.length,
      separatorBuilder: (_, __) => const SizedBox(height: 18),
      itemBuilder: (context, i) => _FavoriteFoodCard(item: mockFavoriteFoods[i]),
    );
  }
}

// ----- RESTAURANTS TAB -----
class _FavoriteRestaurantsTab extends StatelessWidget {
  const _FavoriteRestaurantsTab();

  @override
  Widget build(BuildContext context) {
    if (mockFavoriteRestaurants.isEmpty) {
      return const _EmptySectionMessage(message: "No favorite restaurants yet.");
    }
    return ListView.separated(
      itemCount: mockFavoriteRestaurants.length,
      separatorBuilder: (_, __) => const SizedBox(height: 18),
      itemBuilder: (context, i) =>
          _FavoriteRestaurantCard(item: mockFavoriteRestaurants[i]),
    );
  }
}

// ----- EMPTY MESSAGE -----
class _EmptySectionMessage extends StatelessWidget {
  final String message;
  const _EmptySectionMessage({required this.message});
  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      message,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey[600]),
      textAlign: TextAlign.center,
    ),
  );
}

// ----- RESTAURANT CARD -----
class _FavoriteRestaurantCard extends StatelessWidget {
  final FavoriteRestaurant item;
  const _FavoriteRestaurantCard({required this.item});

  String _formatDateTime(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dt.year, dt.month, dt.day);

    if (date == today) {
      return "Today, ${_formatTime(dt)}";
    } else if (date == today.subtract(const Duration(days: 1))) {
      return "Yesterday, ${_formatTime(dt)}";
    } else {
      return "${date.day}/${date.month}/${date.year}, ${_formatTime(dt)}";
    }
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final ampm = dt.hour < 12 ? "AM" : "PM";
    return "$hour:${dt.minute.toString().padLeft(2, '0')} $ampm";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: const EdgeInsets.only(bottom: 0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                item.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[200],
                  width: 70,
                  height: 70,
                  child: const Icon(Icons.store_mall_directory),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.cuisine,
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 3),
                      Text('${item.rating}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(width: 12),
                      Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        _formatDateTime(item.addedAt),
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                // TODO: Remove from favorites (provider)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"${item.name}" removed from favorites'),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              tooltip: "Remove from favorites",
            ),
          ],
        ),
      ),
    );
  }
}

// ----- FOOD CARD -----
class _FavoriteFoodCard extends StatelessWidget {
  final FavoriteFood item;
  const _FavoriteFoodCard({required this.item});

  String _formatDateTime(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dt.year, dt.month, dt.day);

    if (date == today) {
      return "Today, ${_formatTime(dt)}";
    } else if (date == today.subtract(const Duration(days: 1))) {
      return "Yesterday, ${_formatTime(dt)}";
    } else {
      return "${date.day}/${date.month}/${date.year}, ${_formatTime(dt)}";
    }
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final ampm = dt.hour < 12 ? "AM" : "PM";
    return "$hour:${dt.minute.toString().padLeft(2, '0')} $ampm";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: const EdgeInsets.only(bottom: 0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                item.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[200],
                  width: 70,
                  height: 70,
                  child: const Icon(Icons.fastfood),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.restaurant,
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    children: item.tags
                        .map((tag) => Chip(
                      label: Text(tag, style: theme.textTheme.bodySmall),
                      backgroundColor: Colors.amber[50],
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                    ))
                        .toList(),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 3),
                      Text('${item.rating}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(width: 12),
                      Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        _formatDateTime(item.addedAt),
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                // TODO: Remove from favorites (provider)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"${item.name}" removed from favorites'),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              tooltip: "Remove from favorites",
            ),
          ],
        ),
      ),
    );
  }
}
