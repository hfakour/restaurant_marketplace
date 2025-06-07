import 'package:flutter/material.dart';
import 'core/widgets/bottom_navigation_bar.dart'; // Put AppShell here

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luxury Restaurant Marketplace',
      theme: ThemeData(
        fontFamily: 'Georgia',
        scaffoldBackgroundColor: const Color(0xFFF8F4EF),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown),
        useMaterial3: true,
      ),
      home: const AppShell(), // <- AppShell now handles navigation
      debugShowCheckedModeBanner: false,
    );
  }
}
