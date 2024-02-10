import 'package:apollo_pdv/models/report.dart';
import 'package:apollo_pdv/screens/reports/widgets/analytic_card.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:flutter/material.dart';

class AnalyticsReport extends StatelessWidget {
  const AnalyticsReport({super.key, required this.report});

  final Report report;

  @override
  Widget build(BuildContext context) {
    double size = (MediaQuery.of(context).size.width - (16 * 5)) / 4;

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnalyticCard(
                size: size,
                title: "Faturamento",
                value: Formatters().formatMoneyBRL(value: report.getTotal()),
                image: "images/icons/income.png",
              ),
              AnalyticCard(
                size: size,
                title: "Vendas",
                value: "${report.getSales().length}",
                image: "images/icons/trade.png",
              ),
              AnalyticCard(
                size: size,
                title: "Ticket médio",
                value: Formatters()
                    .formatMoneyBRL(value: report.getAverageTicket()),
                image: "images/icons/money-transfer.png",
              ),
              AnalyticCard(
                size: size,
                title: "Lucro",
                value: Formatters().formatMoneyBRL(value: report.getProfit()),
                image: "images/icons/profits.png",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
