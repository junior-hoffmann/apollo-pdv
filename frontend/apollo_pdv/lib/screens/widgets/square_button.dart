// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  String title;
  String urlImage;
  Function onTap;
  final AppTheme _theme = AppTheme();
  double size;

  SquareButton(
      {required this.title,
      required this.urlImage,
      required this.onTap,
      required this.size,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 4),
      child: SizedBox(
        height: size,
        width: size,
        child: InkWell(
          onTap: () => onTap(),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: SizedBox(
                      height: size * 0.43, child: Image.asset(urlImage)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, right: 8, bottom: 24, left: 8),
                  child: Text(
                    title,
                    style: TextStyle(
                      // fontSize: 20,
                      fontSize: size * 0.1,
                      color: _theme.primaryText,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
