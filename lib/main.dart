import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/app_shell/app_shell.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const AppShell(), // <-- Use your shell here!
      debugShowCheckedModeBanner: false,
    );
  }
}
