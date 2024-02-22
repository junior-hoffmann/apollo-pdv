// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/company.dart';
import 'package:apollo_pdv/models/report.dart';
import 'package:apollo_pdv/pdfs/report_pdf.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class ViewReportScreen extends StatefulWidget {
  Report report;
  Company company = Company(
      name: "Bit Mercado",
      address: {
        "street": "Avenida Ram",
        "number": "8",
        "neighborhood": "Centro",
        "city": "Gramado",
        "uf": "RS",
      },
      cnpj: "12.123.321/0001-69",
      phone: "(54) 9 9682 - 1658");

  ViewReportScreen({super.key, required this.report});

  @override
  State<ViewReportScreen> createState() => _ViewReportScreenState();
}

class _ViewReportScreenState extends State<ViewReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text("Gerador de ticket"),
          ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: PdfPreview(
            canChangeOrientation: false,
            canChangePageFormat: false,
            canDebug: false,
            dpi: 600,
            build: (format) =>
                ReportPdf(report: widget.report, company: widget.company)
                    .getPdf(),
          ),
        ),
      ),
    );
  }
}
