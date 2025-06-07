import 'package:flutter/material.dart';
import '../data/food_mock_data.dart';
import 'category_grid_page.dart';

class CategoryCarousel extends StatelessWidget {
  const CategoryCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final pagedCategories = <List<Map<String, String>>>[];
    for (var i = 0; i < kCategories.length; i += 8) {
      pagedCategories.add(kCategories.skip(i).take(8).toList());
    }

    return SizedBox(
      height: 220,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.98),
        itemCount: pagedCategories.length,
        itemBuilder: (context, idx) => CategoryGridPage(categories: pagedCategories[idx]),
      ),
    );
  }
}
