// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/product_sold.dart';
import 'package:apollo_pdv/models/sale.dart';
import 'package:apollo_pdv/screens/widgets/title_row.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';

class SaleScreen extends StatelessWidget {
  Sale sale;
  final AppTheme _theme = AppTheme();

  SaleScreen({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    List<ProductSold> products = sale.getSale()["products"];
    double fontSize = MediaQuery.of(context).size.width * _theme.tableFontSize;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: SizedBox(
          height: 40,
          child: Image.asset(
            "images/logo/logo_apollo_pdv.png",
          ),
        ),
        actions: [
          IconButton(
              iconSize: 50,
              onPressed: () {},
              icon: Image.asset("images/icons/pdf.png"))
        ],
      ),
      body: Column(
        children: [
          TitleRow(
              title: "Venda nº ${sale.getSerialCode()}",
              color: _theme.primaryText),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:8,  left: 32),
                child: Text(
                  "Data e hora da venda: ${sale.getSale()["date"]}",
                  style: TextStyle(
                    color: _theme.primaryText,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: _theme.borderColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: DataTable(
                            columnSpacing: 16,
                            showCheckboxColumn: false,
                            columns: [
                              DataColumn(
                                  label: Text(
                                "Itens",
                                style: TextStyle(
                                  fontSize: fontSize,
                                ),
                              )),
                              DataColumn(
                                  label: Text(
                                "Subtotal",
                                style: TextStyle(
                                  fontSize: fontSize,
                                ),
                              )),
                              DataColumn(
                                  label: Text(
                                "Desconto",
                                style: TextStyle(
                                  fontSize: fontSize,
                                ),
                              )),
                              DataColumn(
                                  label: Text(
                                "Total",
                                style: TextStyle(
                                  fontSize: fontSize,
                                ),
                              )),
                              DataColumn(
                                  label: Text(
                                "Lucro",
                                style: TextStyle(
                                  fontSize: fontSize,
                                ),
                              )),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      _sumItens(products: products),
                                      style: TextStyle(
                                        fontSize: fontSize,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      Formatters().formatMoneyBRL(
                                          value: sale.getSale()["total"]
                                              ["totalWithoutDiscount"]),
                                      style: TextStyle(
                                        fontSize: fontSize,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      Formatters().formatMoneyBRL(
                                          value: sale.getSale()["discount"]),
                                      style: TextStyle(
                                        fontSize: fontSize,
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(
                                    Formatters().formatMoneyBRL(
                                        value: sale.getSale()["total"]
                                            ["total"]),
                                    style: TextStyle(
                                      fontSize: fontSize,
                                    ),
                                  )),
                                  DataCell(Text(
                                    Formatters().formatMoneyBRL(
                                        value: sale.getSale()["profit"]),
                                    style: TextStyle(
                                      fontSize: fontSize,
                                    ),
                                  )),
                                ],
                              ),
                            ]),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: _theme.borderColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: DataTable(
                            columnSpacing: 16,
                            showCheckboxColumn: false,
                            columns: [
                              DataColumn(
                                  label: Text(
                                "Item",
                                style: TextStyle(
                                  fontSize: fontSize,
                                ),
                              )),
                              DataColumn(
                                  label: Text(
                                "Descrição",
                                style: TextStyle(
                                  fontSize: fontSize,
                                ),
                              )),
                              DataColumn(
                                  label: Text(
                                "Qtd.",
                                style: TextStyle(
                                  fontSize: fontSize,
                                ),
                              )),
                              DataColumn(
                                  label: Text(
                                "Preço un.",
                                style: TextStyle(
                                  fontSize: fontSize,
                                ),
                              )),
                              DataColumn(
                                  label: Text(
                                "Preço total",
                                style: TextStyle(
                                  fontSize: fontSize,
                                ),
                              )),
                            ],
                            rows: List.generate(
                              products.length,
                              (index) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                        fontSize: fontSize,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Text(
                                        products[index].getDescription(),
                                        style: TextStyle(
                                          fontSize: fontSize,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      products[index].getAmount().toString(),
                                      style: TextStyle(
                                        fontSize: fontSize,
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(
                                    Formatters().formatMoneyBRL(
                                        value: products[index].getSalePrice()),
                                    style: TextStyle(
                                      fontSize: fontSize,
                                    ),
                                  )),
                                  DataCell(Text(
                                    Formatters().formatMoneyBRL(
                                        value: products[index].getTotal()),
                                    style: TextStyle(
                                      fontSize: fontSize,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: _theme.borderColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 24),
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
                                        value: sale.getSale()["paymentForm"]
                                            ["money"]))
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
                                Text(sale.getSale()["paymentForm"]
                                            ["creditCard"] ==
                                        0
                                    ? "-"
                                    : Formatters().formatMoneyBRL(
                                        value: sale.getSale()["paymentForm"]
                                            ["creditCard"]))
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
                                Text(sale.getSale()["paymentForm"]
                                            ["debitCard"] ==
                                        0
                                    ? "-"
                                    : Formatters().formatMoneyBRL(
                                        value: sale.getSale()["paymentForm"]
                                            ["debitCard"]))
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
                                        value: sale.getSale()["paymentForm"]
                                            ["pix"]))
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
                                        value: sale.getSale()["paymentForm"]
                                            ["check"]))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _sumItens({required List<ProductSold> products}) {
    int itensAmount = 0;
    for (ProductSold product in products) {
      itensAmount += product.getAmount();
    }
    return itensAmount.toString();
  }
}
