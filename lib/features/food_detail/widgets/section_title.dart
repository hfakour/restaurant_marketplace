import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final double? fontSize;
  const SectionTitle(this.text, {this.fontSize = 18, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
    );
  }
}
