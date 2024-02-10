// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/sale.dart';
import 'package:apollo_pdv/providers/sales_provider.dart';
import 'package:apollo_pdv/screens/reports/widgets/sales_table_report.dart';
import 'package:apollo_pdv/screens/widgets/title_row.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FastReportScreen extends StatelessWidget {
  FastReportScreen({super.key});

  final AppTheme _theme = AppTheme();

  List<Sale> sales = [];

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: Provider.of<SalesProvider>(context).getTodaySales(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasData && !snapshot.hasError) {
                if (snapshot.requireData.isEmpty) {
                  return Center(
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
                            "Hoje ainda não realizamos vendas!",
                            style: TextStyle(
                              color: _theme.primaryColor,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const TitleRow(
                            title: "Relatório Rápido", color: Colors.black),
                        SalesTableReport(sales: snapshot.requireData),
                        
                      ],
                    ),
                  );
                }
              } else {
                return Text(snapshot.error.toString());
              }
          }
        },
      ),
    );
  }
}
