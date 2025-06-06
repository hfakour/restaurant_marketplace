import 'package:flutter/material.dart';

class InfoIconTextRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final TextStyle? textStyle;

  const InfoIconTextRow({
    required this.icon,
    required this.text,
    this.iconColor,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor ?? Colors.brown, size: 20),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: textStyle ?? const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
