// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/sale.dart';
import 'package:apollo_pdv/providers/sales_provider.dart';
import 'package:apollo_pdv/screens/reports/report_screen.dart';
import 'package:apollo_pdv/screens/sales/sale_screen.dart';
import 'package:apollo_pdv/screens/widgets/input.dart';
import 'package:apollo_pdv/screens/widgets/snackbar.dart';
import 'package:apollo_pdv/screens/widgets/title_row.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalesHeader extends StatefulWidget {
  SalesHeader(
      {super.key,
      required this.salesFiltered,
      required this.sales,
      required this.filter});

  List<Sale> salesFiltered;
  List<Sale> sales;
  Function filter;

  Map<String, dynamic> date = {
    "inicial": DateTime.now(),
    "final": DateTime.now()
  };

  TextEditingController controllerFirstlDate = TextEditingController();
  TextEditingController controllerLastlDate = TextEditingController();

  @override
  State<SalesHeader> createState() => _SalesHeaderState();
}

class _SalesHeaderState extends State<SalesHeader> {
  final AppTheme _theme = AppTheme();

  @override
  Widget build(BuildContext contexto) {
    return Container(
      color: _theme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: TitleRow(
                title: "Vendas",
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 96) / 5,
                  child: InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      ).then((value) {
                        widget.date["inicial"] = value;
                        widget.controllerFirstlDate.text =
                            Formatters().formatSimpleDate(date: value!);
                      });
                    },
                    child: TextField(
                      enabled: false,
                      controller: widget.controllerFirstlDate,
                      decoration: const InputDecoration(
                        labelText: "Data Inicial",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 96) / 5,
                  child: InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      ).then((value) {
                        widget.date["final"] = value;
                        widget.controllerLastlDate.text =
                            Formatters().formatSimpleDate(date: value!);
                      });
                    },
                    child: TextField(
                      enabled: false,
                      controller: widget.controllerLastlDate,
                      decoration: const InputDecoration(
                        labelText: "Data Final",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: (MediaQuery.of(context).size.width - 96) / 5,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.filter(
                        initialDate: widget.date["inicial"],
                        finalDate: widget.date["final"],
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _theme.primaryColor,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      shape: ContinuousRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(_theme.borderRadius)),
                    ),
                    child: const Text("Filtrar pela data"),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: (MediaQuery.of(context).size.width - 96) / 5,
                  child: ElevatedButton(
                    onPressed: () {
                      TextEditingController controller =
                          TextEditingController();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Input(
                                    placeholder: "Código da venda",
                                    controller: controller,
                                    context: context,
                                    isNumber: true),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // serial code 1706693927836
                                      try {
                                        Sale sale = widget.sales.firstWhere(
                                            (sale) =>
                                                sale.getSerialCode() ==
                                                controller.text);

                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SaleScreen(sale: sale),
                                                ))
                                            .then((value) =>
                                                Navigator.pop(context));
                                      } catch (e) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(Warnings().snackBar(
                                                value: "Venda não encontrada",
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _theme.primaryColor,
                                      shadowColor: Colors.transparent,
                                      elevation: 0,
                                      shape: ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              _theme.borderRadius)),
                                    ),
                                    child: const Text("Encontrar"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _theme.primaryColor,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      shape: ContinuousRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(_theme.borderRadius)),
                    ),
                    child: const Text("Filtrar pelo número"),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: (MediaQuery.of(context).size.width - 96) / 5,
                  child: ElevatedButton(
                    onPressed: () {
                      DateTime firstDate = DateTime(
                          widget.date["inicial"].year,
                          widget.date["inicial"].month,
                          widget.date["inicial"].day,
                          0,
                          0,
                          0,
                          0,
                          0);

                      DateTime lastDate = DateTime(
                          widget.date["final"].year,
                          widget.date["final"].month,
                          widget.date["final"].day,
                          23,
                          59,
                          59,
                          999,
                          999);

                      Provider.of<SalesProvider>(context, listen: false)
                          .getFilteredSales(
                              firstDateISO: firstDate.toIso8601String(),
                              lastDateString: lastDate.toIso8601String())
                          .then(
                            (sales) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReportScreen(sales: sales),
                              ),
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _theme.secondaryColor,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      shape: ContinuousRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(_theme.borderRadius)),
                    ),
                    child: const Text("Gerar relatório"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
