// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/screens/pdv/widgets_pdv/payment_input.dart';
import 'package:flutter/material.dart';

class PaymentForm extends StatelessWidget {
  PaymentForm({
    super.key,
    required this.moneyController,
    required this.creditController,
    required this.debitController,
    required this.pixController,
    required this.checkController,
    required this.mainContext,
    required this.onChanged,
  });
  TextEditingController moneyController;
  TextEditingController creditController;
  TextEditingController debitController;
  TextEditingController pixController;
  TextEditingController checkController;
  BuildContext mainContext;
  Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentInput(
          title: "Dinheiro",
          icon: "images/icons/dinheiro.png",
          controller: moneyController,
          mainContext: context,
          onChanged: onChanged,
        ),
        PaymentInput(
          title: "Cartão de Crédito",
          icon: "images/icons/cartoes-de-credito.png",
          controller: creditController,
          mainContext: context,
          onChanged: onChanged,
        ),
        PaymentInput(
          title: "Cartão de Débito",
          icon: "images/icons/metodo-de-pagamento.png",
          controller: debitController,
          mainContext: context,
          onChanged: onChanged,
        ),
        PaymentInput(
          title: "Pix",
          icon: "images/icons/pix.png",
          controller: pixController,
          mainContext: context,
          onChanged: onChanged,
        ),
        PaymentInput(
          title: "Cheque",
          icon: "images/icons/verifica.png",
          controller: checkController,
          mainContext: context,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
