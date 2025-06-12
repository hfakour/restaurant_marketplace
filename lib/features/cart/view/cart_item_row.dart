// cart/cart_item_row.dart
// Represents one row in the cart list: image, desc, tags, quantity.

import 'package:flutter/material.dart';
import '../../../core/theme/cart_styles.dart';
import '../model/cart_model.dart';
import 'cart_tags_row.dart';
import 'cart_quantity_button.dart';

class CartItemRow extends StatelessWidget {
  final CartItem item;
  const CartItemRow({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // LEFT COLUMN (image + description + tags)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row: Image + Description
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(CartStyles.cartItemBorderRadius),
                    child: Image.network(
                      item.imageUrl,
                      width: CartStyles.cartItemImageSize,
                      height: CartStyles.cartItemImageSize,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: CartStyles.bgColor,
                        width: CartStyles.cartItemImageSize,
                        height: CartStyles.cartItemImageSize,
                        child: Icon(Icons.fastfood,
                            color: CartStyles.charcoal.withOpacity(0.5), size: 28),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Name and restaurant
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: CartStyles.cartItemNameWeight,
                            color: CartStyles.charcoal,
                            fontSize: CartStyles.cartItemNameFontSize,
                            letterSpacing: -0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.restaurant,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: CartStyles.charcoal.withOpacity(0.5),
                            fontWeight: CartStyles.cartItemRestaurantWeight,
                            fontSize: CartStyles.cartItemRestaurantFontSize,
                            letterSpacing: -0.1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Tags Row
              if (item.tags.isNotEmpty) ...[
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: CartTagsRow(tags: item.tags),
                ),
              ],
            ],
          ),
        ),
        // RIGHT COLUMN (quantity)
        Container(
          height: 68,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CartQuantityButton(
                icon: Icons.remove,
                onPressed: () {}, // TODO: connect logic
                iconColor: CartStyles.charcoal,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${item.quantity}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: CartStyles.charcoal,
                    fontWeight: FontWeight.w800,
                    fontSize: CartStyles.quantityTextFontSize,
                  ),
                ),
              ),
              CartQuantityButton(
                icon: Icons.add,
                onPressed: () {}, // TODO: connect logic
                iconColor: CartStyles.charcoal,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
