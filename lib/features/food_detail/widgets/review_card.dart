import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String comment;
  final double rating;
  final String? userAvatar;

  const ReviewCard({
    required this.name,
    required this.comment,
    required this.rating,
    this.userAvatar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.brown.shade100,
            backgroundImage: userAvatar != null ? NetworkImage(userAvatar!) : null,
            child: userAvatar == null
                ? Text(name.isNotEmpty ? name[0] : '?', style: const TextStyle(color: Colors.brown))
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                RatingBarIndicator(
                  rating: rating,
                  itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                  itemSize: 16,
                ),
                const SizedBox(height: 4),
                Text(comment),
              ],
            ),
          )
        ],
      ),
    );
  }
}
