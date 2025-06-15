import 'package:flutter/material.dart';
import '../../../core/theme/home_styles.dart';

class OverlapCard extends StatelessWidget {
  final Widget child;
  final double topOverlap;
  final EdgeInsetsGeometry padding;
  const OverlapCard({
    required this.child,
    this.topOverlap = 25.0,
    this.padding = const EdgeInsets.fromLTRB(16, 30, 16, 0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -topOverlap,
          left: 8,
          right: 8,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: HomeStyles.cardBg,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(HomeStyles.cardRadius),
                topRight: Radius.circular(HomeStyles.cardRadius),
              ),
              boxShadow: [
                BoxShadow(
                  color: HomeStyles.charcoal.withOpacity(0.07),
                  blurRadius: HomeStyles.cardShadowBlur,
                  offset: HomeStyles.cardShadowOffset,
                ),
              ],
            ),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
