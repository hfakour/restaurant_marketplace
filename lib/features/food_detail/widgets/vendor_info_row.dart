import 'package:flutter/material.dart';
import 'vendor_avatar.dart';
import 'vendor_info_text.dart';

class VendorInfoRow extends StatelessWidget {
  final String vendorImage;
  final String vendorName;
  final String vendorLocation;
  final double rating;
  final int reviewsCount;
  final VoidCallback onViewRestaurant;
  final Color? highlightColor;

  const VendorInfoRow({
    required this.vendorImage,
    required this.vendorName,
    required this.vendorLocation,
    required this.rating,
    required this.reviewsCount,
    required this.onViewRestaurant,
    this.highlightColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final gold = highlightColor ?? const Color(0xFFD4AF37);

    return Row(
      children: [
        VendorAvatar(imageUrl: vendorImage),
        const SizedBox(width: 16),
        Expanded(
          child: VendorInfoText(
            vendorName: vendorName,
            vendorLocation: vendorLocation,
            rating: rating,
            reviewsCount: reviewsCount,
          ),
        ),
        TextButton(
          onPressed: onViewRestaurant,
          child: Text('View Restaurant', style: TextStyle(color: gold)),
        ),
      ],
    );
  }
}
