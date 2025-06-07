import 'package:flutter/material.dart';
import 'category_circle_tile.dart';

class CategoryGridPage extends StatelessWidget {
  final List<Map<String, String>> categories;
  const CategoryGridPage({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        itemCount: categories.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 18,
          crossAxisSpacing: 10,
          childAspectRatio: 0.82,
        ),
        itemBuilder: (context, i) => CategoryCircleTile(
          name: categories[i]['name']!,
          imageUrl: categories[i]['image']!,
        ),
      ),
    );
  }
}
