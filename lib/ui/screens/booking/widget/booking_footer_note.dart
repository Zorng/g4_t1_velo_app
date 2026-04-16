import 'package:flutter/material.dart';

class BookingFooterNote extends StatelessWidget {
  final String text;
  final Color iconColor;
  final Color textColor;

  const BookingFooterNote({
    super.key,
    required this.text,
    this.iconColor = Colors.green,
    this.textColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle, color: iconColor, size: 16),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
