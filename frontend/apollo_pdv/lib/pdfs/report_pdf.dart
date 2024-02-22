// import 'dart:typed_data';
import 'package:apollo_pdv/models/company.dart';
import 'package:apollo_pdv/models/report.dart';
import 'package:apollo_pdv/models/sale.dart';
import 'package:apollo_pdv/pdfs/report/analytics_report_pdf.dart';
import 'package:apollo_pdv/pdfs/report/charts_report.dart';
import 'package:apollo_pdv/pdfs/report/header_report.dart';
import 'package:apollo_pdv/pdfs/report/saled_products.dart';
import 'package:apollo_pdv/pdfs/report/sales_summary.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportPdf {
  Report report;
  Company company;

  ReportPdf({required this.report, required this.company});

  Future<Uint8List> getPdf() async {
    List<pw.Widget> body = [];
    List<Sale> sales = report.getSales();
    final pdf = pw.Document();
    final ByteData logoByte =
        await rootBundle.load('images/logo/logo_apollo_pdv.png');
    final Uint8List logo = logoByte.buffer.asUint8List();

    body.addAll(HeaderReport().get(company: company));
    body.add(
      pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Divider(thickness: 0.4),
          pw.Text(
            "RELATÓRIO DE VENDAS",
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Divider(thickness: 0.4),
        ],
      ),
    );
    body.addAll(AnalyticsReportPdf(report: report).get());
    body.addAll(ChartsReport(report: report).get());
    body.addAll(SalesSummary(sales: sales).get());
    body.addAll(SaledProducts(report: report).get());

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) => body,
        footer: (context) => pw.Column(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 8),
              child: pw.Divider(thickness: 0.4),
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Image(
                  pw.MemoryImage(logo),
                  height: 16,
                  fit: pw.BoxFit.contain,
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return pdf.save();
  }
}
