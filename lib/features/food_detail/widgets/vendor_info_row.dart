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
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const VendorInfoRow({
    required this.vendorImage,
    required this.vendorName,
    required this.vendorLocation,
    required this.rating,
    required this.reviewsCount,
    required this.onViewRestaurant,
    this.highlightColor,
    this.backgroundColor,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final gold = highlightColor ?? const Color(0xFFD4AF37);

    return Container(
      // Remove the color property here (move it to decoration)
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(0, -4), // Only on top
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
        // No borderRadius!
      ),
      child: Row(
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
            child: Text('View', style: TextStyle(color: gold)),
          ),
        ],
      ),
    );
  }
}
