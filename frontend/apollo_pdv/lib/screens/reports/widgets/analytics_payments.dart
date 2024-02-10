import 'package:apollo_pdv/models/report.dart';
import 'package:apollo_pdv/screens/reports/widgets/payment_card_report.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:flutter/material.dart';

class AnalyticsPayments extends StatelessWidget {
  const AnalyticsPayments({super.key, required this.report});

  final Report report;

  @override
  Widget build(BuildContext context) {
    double size = (MediaQuery.of(context).size.width - (16 * 6)) / 5;

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PaymentCardReport(
                size: size,
                title: "Dinheiro",
                value: Formatters()
                    .formatMoneyBRL(value: report.getPayments()["money"]!),
                image: "images/icons/dinheiro.png",
              ),
              PaymentCardReport(
                size: size,
                title: "Cartão de crédito",
                value: Formatters()
                    .formatMoneyBRL(value: report.getPayments()["creditCard"]!),
                image: "images/icons/cartoes-de-credito.png",
              ),
              PaymentCardReport(
                size: size,
                title: "Cartão de débito",
                value: Formatters()
                    .formatMoneyBRL(value: report.getPayments()["debitCard"]!),
                image: "images/icons/metodo-de-pagamento.png",
              ),
              PaymentCardReport(
                size: size,
                title: "Pix",
                value: Formatters()
                    .formatMoneyBRL(value: report.getPayments()["pix"]!),
                image: "images/icons/pix.png",
              ),
              PaymentCardReport(
                size: size,
                title: "Cheque",
                value: Formatters()
                    .formatMoneyBRL(value: report.getPayments()["check"]!),
                image: "images/icons/verifica.png",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
