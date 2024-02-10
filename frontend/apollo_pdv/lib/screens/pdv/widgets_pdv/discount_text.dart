// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/utils/formaters.dart';
import 'package:flutter/material.dart';

class DiscountText extends StatelessWidget {
  DiscountText({super.key, required this.discount, required this.total});
  double discount;
  double total;

  @override
  Widget build(BuildContext context) {
    return discount == 0
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
                "Total da compra ${Formatters().formatMoneyBRL(value: total)} - desconto de ${Formatters().formatMoneyBRL(value: discount)}"),
          );
  }
}
