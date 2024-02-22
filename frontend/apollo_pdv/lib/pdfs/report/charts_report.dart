import 'package:apollo_pdv/models/report.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ChartsReport {
  late Report _report;
  final List<pw.Widget> _sumary = [];

  ChartsReport({required Report report}) {
    _report = report;
  }

  void _addChart() {
    Map<String, dynamic> payments = {
      "money": {
        "percent": (_report.getPayments()["money"]! / _report.getTotal()) * 100,
        "color": PdfColors.orange,
      },
      "creditCard": {
        "percent":
            (_report.getPayments()["creditCard"]! / _report.getTotal()) * 100,
        "color": PdfColors.red,
      },
      "debitCard": {
        "percent":
            (_report.getPayments()["debitCard"]! / _report.getTotal()) * 100,
        "color": PdfColors.blue,
      },
      "pix": {
        "percent": (_report.getPayments()["pix"]! / _report.getTotal()) * 100,
        "color": PdfColors.green,
      },
      "check": {
        "percent": (_report.getPayments()["check"]! / _report.getTotal()) * 100,
        "color": PdfColors.purple,
      },
    };

    _sumary.add(
      pw.SizedBox(
        height: 80,
        width: 220,
        child: pw.Chart(
          grid: pw.PieGrid(),
          datasets: [
            pw.PieDataSet(
              value: payments["money"]["percent"],
              color: payments["money"]["color"],
            ),
            pw.PieDataSet(
              value: payments["creditCard"]["percent"],
              color: payments["creditCard"]["color"],
            ),
            pw.PieDataSet(
              value: payments["debitCard"]["percent"],
              color: payments["debitCard"]["color"],
            ),
            pw.PieDataSet(
              value: payments["pix"]["percent"],
              color: payments["pix"]["color"],
            ),
            pw.PieDataSet(
              value: payments["check"]["percent"],
              color: payments["check"]["color"],
            ),
          ],
          right: pw.Padding(
            padding: const pw.EdgeInsets.only(left: 8),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Dinheiro: ${double.parse(payments["money"]["percent"].toString()).toStringAsFixed(2)}%",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: payments["money"]["color"],
                  ),
                ),
                pw.Text(
                  "Cartão de crédito: ${double.parse(payments["creditCard"]["percent"].toString()).toStringAsFixed(2)}%",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: payments["creditCard"]["color"],
                  ),
                ),
                pw.Text(
                  "Cartão de débito: ${double.parse(payments["debitCard"]["percent"].toString()).toStringAsFixed(2)}%",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: payments["debitCard"]["color"],
                  ),
                ),
                pw.Text(
                  "Pix: ${double.parse(payments["pix"]["percent"].toString()).toStringAsFixed(2)}%",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: payments["pix"]["color"],
                  ),
                ),
                pw.Text(
                  "Cheque: ${double.parse(payments["check"]["percent"].toString()).toStringAsFixed(2)}%",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: payments["check"]["color"],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<pw.Widget> get() {
    _addChart();
    return _sumary;
  }
}
