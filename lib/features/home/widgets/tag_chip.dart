import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String text;
  const TagChip(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        text,
        style: const TextStyle(fontSize: 10, color: Colors.brown),
      ),
      backgroundColor: Colors.brown.shade50,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
