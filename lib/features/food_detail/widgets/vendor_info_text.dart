import 'package:flutter/material.dart';

class VendorInfoText extends StatelessWidget {
  final String vendorName;
  final String vendorLocation;
  final double rating;
  final int reviewsCount;

  const VendorInfoText({
    required this.vendorName,
    required this.vendorLocation,
    required this.rating,
    required this.reviewsCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          vendorName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Text(
          vendorLocation,
          style: TextStyle(color: Colors.grey[600]),
        ),
        Text(
          '⭐ $rating ($reviewsCount reviews)',
          style: TextStyle(color: Colors.grey[700]),
        ),
      ],
    );
  }
}
