import 'package:apollo_pdv/models/report.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AnalyticsReportPdf {
  late Report _report;

  AnalyticsReportPdf({required Report report}) {
    _report = report;
  }

  List<pw.Widget> get() {
    List<pw.Widget> itens = [];

    itens.add(
      pw.Padding(
        padding: const pw.EdgeInsets.all(8),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
          children: [
            _card(
              title: "Faturamento",
              value: Formatters().formatMoneyBRL(value: _report.getTotal()),
            ),
            _card(
              title: "Vendas",
              value: "${_report.getSales().length}",
            ),
            _card(
              title: "Ticket médio",
              value: Formatters()
                  .formatMoneyBRL(value: _report.getAverageTicket()),
            ),
            _card(
              title: "Lucro",
              value: Formatters().formatMoneyBRL(value: _report.getProfit()),
            ),
          ],
        ),
      ),
    );

    return itens;
  }

  pw.Widget _card({required String title, required String value}) {
    return pw.Container(
      decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.grey),
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8))),
      // width: 100,
      // height: 100,
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(8),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 8),
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            pw.Text(
              value,
              style: const pw.TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
