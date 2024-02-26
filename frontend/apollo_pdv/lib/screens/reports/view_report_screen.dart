// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/report.dart';
import 'package:apollo_pdv/pdfs/report_pdf.dart';
import 'package:apollo_pdv/providers/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class ViewReportScreen extends StatefulWidget {
  Report report;

  ViewReportScreen({super.key, required this.report});

  @override
  State<ViewReportScreen> createState() => _ViewReportScreenState();
}

class _ViewReportScreenState extends State<ViewReportScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CompanyProvider>(context);
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
                ReportPdf(report: widget.report, company: provider.company())
                    .getPdf(),
          ),
        ),
      ),
    );
  }
}
