// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  String title;
  String urlImage;
  Function onTap;
  double size;
  bool isSelected;
  final AppTheme _theme = AppTheme();

  NavigationButton({
    required this.title,
    required this.urlImage,
    required this.onTap,
    required this.size,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: InkWell(
        onTap: () => onTap(),
        child: Column(
          children: [
            SizedBox(height: size * 0.43, child: Image.asset(urlImage)),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                right: 8,
                bottom: 24,
                left: 8,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: size * 0.1,
                  color: isSelected ? _theme.primaryColor : _theme.primaryText,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
