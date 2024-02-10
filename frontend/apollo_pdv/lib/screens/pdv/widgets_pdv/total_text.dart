// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/utils/formaters.dart';
import 'package:flutter/material.dart';

class TotalText extends StatelessWidget {
  TotalText(
      {super.key,
      required this.text,
      required this.total,
      required this.fontSize,
      required this.textColor});

  double fontSize;
  Color textColor;
  double total;
  String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: fontSize,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "R\$",
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
            Text(
              Formatters().formatMoneyBRLNoSimbol(value: total),
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: (fontSize * 2),
              ),
            )
          ],
        )
      ],
    );
  }
}
