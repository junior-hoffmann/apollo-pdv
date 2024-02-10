// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/sale.dart';
import 'package:apollo_pdv/screens/sales/sale_screen.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:flutter/material.dart';

class SalesTable extends StatefulWidget {
  SalesTable({super.key, required this.salesFiltered, required this.fontSize});

  late List<Sale> salesFiltered;
  double fontSize;

  @override
  State<SalesTable> createState() => _SalesTableState();
}

class _SalesTableState extends State<SalesTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
        
          child: DataTable( 
            
            columnSpacing: 2,
            showCheckboxColumn: false,
            columns: [
              DataColumn(
                label: Text(
                  "Nº",
                  style: TextStyle(
                    fontSize: widget.fontSize,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  "Data e hora",
                  style: TextStyle(
                    fontSize: widget.fontSize,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  "Qtd. de itens",
                  style: TextStyle(
                    fontSize: widget.fontSize,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  "Forma de pagamento",
                  style: TextStyle(
                    fontSize: widget.fontSize,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  "Total da venda",
                  style: TextStyle(
                    fontSize: widget.fontSize,
                  ),
                ),
              ),
            ],
            rows: List.generate(
              widget.salesFiltered.length,
              (index) => DataRow(
                onSelectChanged: (_) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SaleScreen(sale: widget.salesFiltered[index]),
                      ));
                },
                cells: [
                  DataCell(
                    Text(
                      widget.salesFiltered[index].getSerialCode(),
                      style: TextStyle(
                        fontSize: widget.fontSize,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      widget.salesFiltered[index].getSale()["date"],
                      style: TextStyle(
                        fontSize: widget.fontSize,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      widget.salesFiltered[index]
                          .getSale()["products"]
                          .length
                          .toString(),
                      style: TextStyle(
                        fontSize: widget.fontSize,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        paymentForm(
                            paymentForm: widget.salesFiltered[index]
                                .getSale()["paymentForm"]),
                        style: TextStyle(
                          fontSize: widget.fontSize,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      Formatters().formatMoneyBRL(
                          value: widget.salesFiltered[index].getSale()["total"]
                              ["total"]),
                      style: TextStyle(
                        fontSize: widget.fontSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
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
