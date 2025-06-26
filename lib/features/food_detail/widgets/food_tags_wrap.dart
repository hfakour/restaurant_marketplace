import 'package:flutter/material.dart';

class FoodTagsWrap extends StatelessWidget {
  final List<String> tags;
  const FoodTagsWrap({required this.tags, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: tags
          .map((tag) =>
          Chip(label: Text(tag), backgroundColor: Colors.brown.shade50))
          .toList(),
    );
  }
}
