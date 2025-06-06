import 'package:flutter/material.dart';

class VendorAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;
  const VendorAvatar({required this.imageUrl, this.radius = 28, super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}
