import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingRow extends StatelessWidget {
  final double rating;
  final int reviewsCount;
  final double iconSize;
  const RatingRow({
    required this.rating,
    required this.reviewsCount,
    this.iconSize = 24,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) =>
          const Icon(Icons.star_rounded, color: Colors.amber),
          itemSize: iconSize,
        ),
        const SizedBox(width: 8),
        Text('($reviewsCount Reviews)', style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }
}
