// features/home/widgets/search_bar.dart
import 'package:flutter/material.dart';

import '../../../core/theme/home_styles.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: HomeStyles.cardBg,
          border: Border.all(color: HomeStyles.subtleGray, width: 1.3),
          borderRadius: BorderRadius.circular(HomeStyles.searchCardRadius),
          boxShadow: [
            BoxShadow(
              color: HomeStyles.charcoal.withOpacity(0.04),
              blurRadius: 7,
              offset: HomeStyles.cardShadowOffset,
            ),
          ],
        ),
        child: Padding(
          padding: HomeStyles.searchPad,
          child: Row(
            children: [
              Icon(Icons.search, color:HomeStyles.charcoal,size: HomeStyles.searchIconSize),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search foods or restaurants...",
                    hintStyle: TextStyle(color: HomeStyles.charcoal.withOpacity(0.30)),
                  ),
                  style: TextStyle(color: HomeStyles.charcoal, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
