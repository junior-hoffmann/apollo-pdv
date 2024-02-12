// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/report.dart';
import 'package:apollo_pdv/models/sale.dart';
import 'package:apollo_pdv/screens/reports/widgets/analytics_payments.dart';
import 'package:apollo_pdv/screens/reports/widgets/analytics_report.dart';
import 'package:apollo_pdv/screens/reports/widgets/sales_table_report.dart';
import 'package:apollo_pdv/screens/widgets/title_row.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key, required this.sales});

  List<Sale> sales;

  @override
  Widget build(BuildContext context) {
    Report report = Report(sales: sales);
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
            icon: Image.asset("images/icons/pdf.png"),
          ),
        ],
      ),
      body: sales.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const TitleRow(title: "Relatório", color: Colors.black),
                  AnalyticsReport(report: report),
                  const TitleRow(
                      title: "Métodos de pagamentos", color: Colors.black),
                  AnalyticsPayments(report: report),
                  const TitleRow(title: "Histórico", color: Colors.black),
                  SalesTableReport(sales: sales),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: Image.asset("images/icons/sem-vendas.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      "Sem vendas realizadas para o período selecionado!",
                      style: TextStyle(
                        color: AppTheme().primaryColor,
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
