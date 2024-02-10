import 'package:flutter/material.dart';

class AppTheme {
  // Colors ----------
  final Color _primaryColor = const Color.fromARGB(255, 56, 144, 244);
  final Color _secondaryColor = const Color.fromARGB(255, 57, 72, 103);
  final Color _tertiaryColor = const Color.fromARGB(255, 155, 164, 181);
  final Color _backgroundColor = const Color.fromARGB(255, 250, 250, 250);
  final Color _cardColor = const Color.fromARGB(255, 241, 246, 249);
  final Color _primaryText = const Color.fromARGB(255, 33, 42, 62);
  final Color _secondaryText = const Color.fromARGB(255, 160, 160, 160);
  final Color _bottomBarItemColor = const Color.fromARGB(255, 44, 57, 86);
  final Color _tableRowColor = const Color.fromARGB(255, 250, 250, 250);
  final Color _borderColor = const Color.fromARGB(255, 220, 220, 220);

  // POST-IT COLORS
  final Color _postitYellow = const Color.fromARGB(255, 255, 247, 64);
  final Color _postitRed = const Color.fromARGB(255, 255, 101, 163);
  Color get postitYellow => _postitYellow;
  Color get postitRed => _postitRed;

  Color get primaryColor => _primaryColor;
  Color get secondaryColor => _secondaryColor;
  Color get tertiaryColor => _tertiaryColor;
  Color get backgroundColor => _backgroundColor;
  Color get cardColor => _cardColor;
  Color get primaryText => _primaryText;
  Color get secondaryText => _secondaryText;
  Color get bottomBarItemColor => _bottomBarItemColor;
  Color get borderColor => _borderColor;

  double get tableFontSize => 0.015;

  Color tableRowColor(Set<MaterialState> states) {
    return _tableRowColor;
  }

  final double _borderRadius = 16;
  double get borderRadius => _borderRadius;

  final OutlineInputBorder _inputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
  );

  OutlineInputBorder get inputBorder => _inputBorder;
}
