import 'package:flutter/material.dart';

class FoodImageBanner extends StatelessWidget {
  final String imageUrl;
  final String label;
  const FoodImageBanner({
    required this.imageUrl,
    this.label = "Chef's Signature",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          height: 280,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Container(
            color: Colors.black54,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
