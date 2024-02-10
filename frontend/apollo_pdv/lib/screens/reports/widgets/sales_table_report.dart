// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/product_sold.dart';
import 'package:apollo_pdv/models/sale.dart';
import 'package:apollo_pdv/screens/sales/sale_screen.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';

class SalesTableReport extends StatefulWidget {
  SalesTableReport({super.key, required this.sales});

  late List<Sale> sales;

  @override
  State<SalesTableReport> createState() => _SalesTableReportState();
}

class _SalesTableReportState extends State<SalesTableReport> {
  @override
  Widget build(BuildContext context) {
    double fontSize =
        MediaQuery.of(context).size.width * AppTheme().tableFontSize;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DataTable(
        columnSpacing: 2,
        showCheckboxColumn: false,
        columns: [
          DataColumn(
            label: Text(
              "Nº",
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              "Qtd. de itens",
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              "Forma de pagamento",
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              "Total da venda",
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              "Lucro",
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
        ],
        rows: List.generate(
          widget.sales.length,
          (index) => DataRow(
            onSelectChanged: (_) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SaleScreen(sale: widget.sales[index]),
                  ));
            },
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
                Text(
                  _sumItens(
                      products: widget.sales[index].getSale()["products"]),
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Text(
                    paymentForm(
                        paymentForm:
                            widget.sales[index].getSale()["paymentForm"]),
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ),
              DataCell(
                Text(
                  Formatters().formatMoneyBRL(
                      value: widget.sales[index].getSale()["total"]["total"]),
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
              ),
              DataCell(Text(
                Formatters().formatMoneyBRL(
                    value: widget.sales[index].getSale()["profit"]),
                style: TextStyle(
                  fontSize: fontSize,
                ),
              )),
            ],
          ),
        ),
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

  String paymentForm({required Map<String, dynamic> paymentForm}) {
    List<String> methods = [];

    if (paymentForm.containsKey("money") && paymentForm["money"] > 0) {
      methods.add("Dinheiro");
    }
    if (paymentForm.containsKey("creditCard") &&
        paymentForm["creditCard"] > 0) {
      methods.add("Cartão de Crédito");
    }
    if (paymentForm.containsKey("debitCard") && paymentForm["debitCard"] > 0) {
      methods.add("Cartão de Débito");
    }
    if (paymentForm.containsKey("pix") && paymentForm["pix"] > 0) {
      methods.add("Pix");
    }
    if (paymentForm.containsKey("check") && paymentForm["check"] > 0) {
      methods.add("Cheque");
    }

    if (methods.isEmpty) {
      return "Sem informações de pagamento";
    } else {
      return methods.join(' e ');
    }
  }
}
