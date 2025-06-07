import 'package:flutter/material.dart';

class ReviewTile extends StatelessWidget {
  final dynamic r;
  const ReviewTile({required this.r, super.key});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        backgroundColor: Colors.brown.shade100,
        backgroundImage: r.userAvatar != null ? NetworkImage(r.userAvatar!) : null,
        child: r.userAvatar == null
            ? Text(r.userName[0], style: const TextStyle(color: Colors.brown))
            : null,
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(r.userName, style: const TextStyle(fontWeight: FontWeight.w600)),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 2),
                Text('${r.rating}', style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 4),
            Text(r.comment),
          ],
        ),
      )
    ],
  );
}
