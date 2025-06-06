import 'package:flutter/material.dart';

class CustomizationChips extends StatelessWidget {
  final List<String> options;
  const CustomizationChips({required this.options, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: options
          .map((option) => Chip(
        label: Text(option),
        backgroundColor: Colors.brown.shade50,
      ))
          .toList(),
    );
  }
}
