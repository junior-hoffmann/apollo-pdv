// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentInput extends StatelessWidget {
  PaymentInput({
    super.key,
    required this.title,
    required this.icon,
    required this.controller,
    required this.mainContext,
    required this.onChanged,
  });

  String title;
  String icon;
  TextEditingController controller;
  BuildContext mainContext;
  Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: SizedBox(
              height: 48,
              child: Image.asset(icon),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: TextField(
              controller: controller,
              inputFormatters: [
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
              ],
              onChanged: (value) => onChanged(),
              decoration: InputDecoration(
                hintText: title,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
