import 'package:flutter/material.dart';

class CategoryCircleTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  const CategoryCircleTile({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.brown.withOpacity(0.10),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Colors.brown),
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 64,
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.brown,
            ),
          ),
        ),
      ],
    );
  }
}
