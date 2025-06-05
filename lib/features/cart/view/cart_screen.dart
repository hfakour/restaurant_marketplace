import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.brown,
      ),
      body: const Center(
        child: Text(
          'No items in your cart yet!',
          style: TextStyle(fontSize: 22, color: Colors.brown),
        ),
      ),
    );
  }
}
