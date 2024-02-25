import 'dart:typed_data';

import 'package:apollo_pdv/screens/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PrintTicket {
  Uint8List pdf;
  BuildContext context;

  PrintTicket({required this.pdf, required this.context}) {
    _print();
  }

  void _print() async {
    try {
      Printer printer = const Printer(url: "apollopdvprinter");
      await Printing.directPrintPdf(
        printer: printer,
        onLayout: (format) => pdf,
      );
    } catch (_) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        Warnings().snackBar(
          value: "Impressora térmica não reconhecida!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        ),
      );
    }
  }
}
