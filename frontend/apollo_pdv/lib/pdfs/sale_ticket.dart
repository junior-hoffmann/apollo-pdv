// import 'dart:typed_data';
import 'package:apollo_pdv/models/company.dart';
import 'package:apollo_pdv/models/sale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SaleTicket {
  Sale sale;
  Company company;

  SaleTicket({required this.sale, required this.company});

  Future<Uint8List> getPdf() async {
    final pdf = pw.Document();

    final ByteData logoByte = await rootBundle.load('images/icons/conta.png');
    final Uint8List logo = logoByte.buffer.asUint8List();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.roll57,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(company.getName(), style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold
                      ),),
                    pw.Text(
                      "${company.getAddress()["street"]},${company.getAddress()["number"]}, B. ${company.getAddress()["neighborhood"]}. ${company.getAddress()["city"]} - ${company.getAddress()["uf"]}",
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.normal
                      ),
                    ),
                  ]),
              // pw.Row(
              //   mainAxisAlignment: pw.MainAxisAlignment.center,
              //   children: [
              //     pw.Image(
              //       pw.MemoryImage(logo),
              //       fit: pw.BoxFit.contain,
              //       height: 50,
              //       width: 100,
              //     ),
              //   ],
              // )
            ],
          ); // Center
        }));
    return pdf.save(); // Pag
  }
}
