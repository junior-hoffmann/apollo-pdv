// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  Input({
    super.key,
    required this.placeholder,
    required this.controller,
    required this.context,
    required this.isNumber,
  });
  late String placeholder;
  late TextEditingController controller;
  late BuildContext context;
  late bool isNumber;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      inputFormatters: isNumber
          ? [
              // FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              TextInputFormatter.withFunction(
                (oldValue, newValue) {
                  // Permite apenas uma vírgula no campo de entrada
                  if (newValue.text.contains(',') &&
                      oldValue.text.contains(',')) {
                    return oldValue;
                  }
                  return newValue;
                },
              ),
            ]
          : [],
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: placeholder,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
