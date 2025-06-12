// cart/cart_tags_row.dart
// Renders the tag chips for each cart item.

import 'package:flutter/material.dart';
import '../../../core/theme/cart_styles.dart';

class CartTagsRow extends StatelessWidget {
  final List<String> tags;
  static const int maxTags = 4;
  const CartTagsRow({required this.tags, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showTags = tags.length > maxTags ? tags.sublist(0, maxTags) : tags;
    final remaining = tags.length - maxTags;

    return Wrap(
      spacing: 7,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ...showTags.map(
              (tag) => Container(
            padding: CartStyles.tagPad,
            decoration: BoxDecoration(
              color: CartStyles.subtleGray,
              borderRadius: BorderRadius.circular(CartStyles.tagBorderRadius),
            ),
            child: Text(
              tag,
              style: theme.textTheme.bodySmall?.copyWith(
                color: CartStyles.charcoal,
                fontWeight: CartStyles.tagFontWeight,
                fontSize: CartStyles.tagFontSize,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ),
        if (remaining > 0)
          Container(
            padding: CartStyles.tagPad,
            decoration: BoxDecoration(
              color: CartStyles.subtleGray,
              borderRadius: BorderRadius.circular(CartStyles.tagBorderRadius),
            ),
            child: Text(
              "+$remaining",
              style: theme.textTheme.bodySmall?.copyWith(
                color: CartStyles.charcoal,
                fontWeight: CartStyles.tagFontWeight,
                fontSize: CartStyles.tagFontSize,
                letterSpacing: -0.1,
              ),
            ),
          ),
      ],
    );
  }
}
