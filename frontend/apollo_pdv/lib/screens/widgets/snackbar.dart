import 'package:flutter/material.dart';

class Warnings {
  SnackBar snackBar({
    required String value,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
    );
  }
}
