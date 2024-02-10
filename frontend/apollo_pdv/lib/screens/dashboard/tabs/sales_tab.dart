// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/sale.dart';
import 'package:apollo_pdv/screens/dashboard/tabs/widgets_tabs/sales_header.dart';
import 'package:apollo_pdv/screens/dashboard/tabs/widgets_tabs/sales_table.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';

class SalesTab extends StatefulWidget {
  List<Sale> sales;

  SalesTab({required this.sales, Key? key}) : super(key: key);

  @override
  State<SalesTab> createState() => _SalesTabState();
}

class _SalesTabState extends State<SalesTab> {
  TextEditingController nomeController = TextEditingController();
  late List<Sale> salesFiltered;

  @override
  void initState() {
    super.initState();
    salesFiltered = List.from(widget.sales);
  }

  @override
  Widget build(BuildContext context) {
    double fontSize =
        MediaQuery.of(context).size.width * AppTheme().tableFontSize;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SalesHeader(
              salesFiltered: salesFiltered,
              sales: widget.sales,
              filter: filterSalesByDate,
            ),
            SalesTable(salesFiltered: salesFiltered, fontSize: fontSize),
          ],
        ),
      ),
    );
  }

  bool compareDate(
      {required DateTime firstDate,
      required DateTime secondDate,
      required bool isAfter}) {
    bool isTheSame = firstDate.day == secondDate.day &&
        firstDate.month == secondDate.month &&
        firstDate.year == secondDate.year;

    if (isAfter) {
      return firstDate.isAfter(secondDate) || isTheSame;
    } else {
      return firstDate.isBefore(secondDate) || isTheSame;
    }
  }

  void filterSalesByDate(
      {required DateTime initialDate, required DateTime finalDate}) {
    setState(() {
      salesFiltered = widget.sales.where((sale) {
        return compareDate(
                firstDate: sale.getDate(),
                secondDate: initialDate,
                isAfter: true) &&
            compareDate(
                firstDate: sale.getDate(),
                secondDate: finalDate,
                isAfter: false);
      }).toList();
    });
  }
}
