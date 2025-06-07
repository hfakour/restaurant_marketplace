import 'package:flutter/material.dart';

const Color kAmber = Colors.amber;
const Color kBrown = Color(0xFF8D6748);

// --------- MOCK DATA ---------
const List<_SearchResult> mockResults = [
  _SearchResult(
      name: "Spicy Ramen",
      type: "Food",
      sub: "Tokyo Bowl",
      imageUrl: "https://images.unsplash.com/photo-1464306076886-debca5e8a6b0"),
  _SearchResult(
      name: "BBQ Beef Burger",
      type: "Food",
      sub: "Urban Grill",
      imageUrl: "https://images.unsplash.com/photo-1550547660-d9450f859349"),
  _SearchResult(
      name: "Tokyo Bowl",
      type: "Restaurant",
      sub: "Japanese Cuisine",
      imageUrl: "https://images.unsplash.com/photo-1504674900247-0877df9cc836"),
  _SearchResult(
      name: "Urban Grill",
      type: "Restaurant",
      sub: "BBQ & Grill",
      imageUrl: "https://images.unsplash.com/photo-1550547660-d9450f859349"),
];

// --------- MAIN SCREEN ---------
class SearchResultsScreen extends StatefulWidget {
  final String query;
  const SearchResultsScreen({super.key, required this.query});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final foods = mockResults
        .where((r) => r.type == "Food" && _match(r, widget.query))
        .toList();
    final restaurants = mockResults
        .where((r) => r.type == "Restaurant" && _match(r, widget.query))
        .toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Results for "${widget.query}"'),
          elevation: 0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: _SearchTabBar(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: TabBarView(
            children: [
              _ResultsList(type: "Food", results: foods),
              _ResultsList(type: "Restaurant", results: restaurants),
            ],
          ),
        ),
      ),
    );
  }

  bool _match(_SearchResult r, String query) {
    return r.name.toLowerCase().contains(query.toLowerCase()) ||
        r.sub.toLowerCase().contains(query.toLowerCase());
  }
}

// --------- CUSTOM TABBAR ---------
class _SearchTabBar extends StatelessWidget {
  const _SearchTabBar();

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 4.0,
          color: kAmber,
        ),
        insets: EdgeInsets.symmetric(horizontal: 28.0),
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

// --------- RESULTS LIST ---------
class _ResultsList extends StatelessWidget {
  final String type;
  final List<_SearchResult> results;
  const _ResultsList({required this.type, required this.results});

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Center(
        child: Text(
          "No $type found.",
          style: const TextStyle(
            color: kBrown,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );
    }
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 18),
      itemBuilder: (context, i) => _SearchResultTile(results[i]),
    );
  }
}

// --------- RESULT TILE ---------
class _SearchResultTile extends StatelessWidget {
  final _SearchResult item;
  const _SearchResultTile(this.item);

  @override
  Widget build(BuildContext context) {
    final isFood = item.type == "Food";
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            item.imageUrl,
            width: 54,
            height: 54,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Icon(
              isFood ? Icons.fastfood : Icons.store_mall_directory,
              color: kBrown,
              size: 36,
            ),
          ),
        ),
        title: Text(
          item.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: kBrown,
            fontSize: 17,
          ),
        ),
        subtitle: Text(item.sub, style: const TextStyle(color: Colors.grey)),
        onTap: () {
          // TODO: Navigate to detail page
        },
      ),
    );
  }
}

// --------- DATA MODEL ---------
class _SearchResult {
  final String name;
  final String type; // "Food" or "Restaurant"
  final String sub;
  final String imageUrl;

  const _SearchResult({
    required this.name,
    required this.type,
    required this.sub,
    required this.imageUrl,
  });
}
