import 'package:flutter/material.dart';
import '../../../core/theme/home_styles.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
    backgroundColor: HomeStyles.charcoal,
    scrolledUnderElevation: 0,
    title: const Text(
      "Good evening, Hassan 👋",
      style: TextStyle(
        color: Colors.white,
        fontWeight: HomeStyles.appBarFontWeight,
        fontSize: HomeStyles.appBarFontSize,
        letterSpacing: -1,
      ),
    ),
    centerTitle: false,
  );
}
