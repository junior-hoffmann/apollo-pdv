import 'package:apollo_pdv/models/sale.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  PaymentCard({super.key, required this.sale});

  final Sale sale;
  final AppTheme _theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: _theme.borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Meios de pagamento",
                          style: TextStyle(
                            color: _theme.primaryText,
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            width: 40,
                            child: Image.asset(
                              "images/icons/dinheiro.png",
                            )),
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text("Dinheiro"),
                        ),
                      ],
                    ),
                    Text(sale.getSale()["paymentForm"]["money"] == 0
                        ? "-"
                        : Formatters().formatMoneyBRL(
                            value: sale.getSale()["paymentForm"]["money"]))
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            width: 40,
                            child: Image.asset(
                              "images/icons/cartoes-de-credito.png",
                            )),
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text("Cartão de crédito"),
                        ),
                      ],
                    ),
                    Text(sale.getSale()["paymentForm"]["creditCard"] == 0
                        ? "-"
                        : Formatters().formatMoneyBRL(
                            value: sale.getSale()["paymentForm"]["creditCard"]))
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            width: 40,
                            child: Image.asset(
                              "images/icons/metodo-de-pagamento.png",
                            )),
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text("Cartão de débito"),
                        ),
                      ],
                    ),
                    Text(sale.getSale()["paymentForm"]["debitCard"] == 0
                        ? "-"
                        : Formatters().formatMoneyBRL(
                            value: sale.getSale()["paymentForm"]["debitCard"]))
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            width: 40,
                            child: Image.asset(
                              "images/icons/pix.png",
                            )),
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text("Pix"),
                        ),
                      ],
                    ),
                    Text(sale.getSale()["paymentForm"]["pix"] == 0
                        ? "-"
                        : Formatters().formatMoneyBRL(
                            value: sale.getSale()["paymentForm"]["pix"]))
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            width: 40,
                            child: Image.asset(
                              "images/icons/verifica.png",
                            )),
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text("Cheque"),
                        ),
                      ],
                    ),
                    Text(sale.getSale()["paymentForm"]["check"] == 0
                        ? "-"
                        : Formatters().formatMoneyBRL(
                            value: sale.getSale()["paymentForm"]["check"]))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
