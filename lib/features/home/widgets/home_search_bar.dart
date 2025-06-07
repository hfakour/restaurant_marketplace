import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  const HomeSearchBar({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search foods or restaurants...',
          hintStyle: TextStyle(
            color: Colors.brown.shade300,
            fontFamily: 'Georgia',
            fontSize: 16,
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
        style: const TextStyle(
          color: Colors.brown,
          fontSize: 17,
          fontWeight: FontWeight.w500,
          fontFamily: 'Georgia',
        ),
        onChanged: onChanged,
      ),
    );
  }
}
