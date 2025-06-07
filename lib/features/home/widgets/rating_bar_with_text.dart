import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarWithText extends StatelessWidget {
  final double rating;
  final int reviews;
  const RatingBarWithText({required this.rating, required this.reviews, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) => const Icon(Icons.star, color: Color(0xFFD4AF37)),
          itemSize: 16,
        ),
        const SizedBox(width: 6),
        Text(
          '$rating',
          style: const TextStyle(
            color: Color(0xFFD4AF37),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '($reviews)',
          style: TextStyle(
            color: Colors.brown.shade400,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
