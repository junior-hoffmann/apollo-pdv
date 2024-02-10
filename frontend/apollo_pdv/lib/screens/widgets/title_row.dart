import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({
    required this.title,
    required this.color,
    super.key,
  });

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 32),
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w400,
              fontSize: 24,
            ),
          ),
        )
      ],
    );
  }
}
