import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomFloatingButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return FloatingActionButton(
      backgroundColor: isDarkMode ? Colors.green[700] : Color(0xFF25AE4B),
      shape: CircleBorder(),
      onPressed: onPressed,
      child: Icon(
        Icons.shopping_cart_outlined,
        color: isDarkMode ? Colors.black : Colors.white,
        size: 30,
      ),
    );
  }
}
