// import 'dart:typed_data';
import 'package:apollo_pdv/models/company.dart';
import 'package:apollo_pdv/models/product_sold.dart';
import 'package:apollo_pdv/models/sale.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:apollo_pdv/utils/print_ticket.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SaleTicket {
  Sale sale;
  Company company;

  SaleTicket({required this.sale, required this.company});

  void getAndPrintPdf() async {
    List<ProductSold> products = sale.getSale()["products"];

    final pdf = pw.Document();

    final ByteData logoByte =
        await rootBundle.load('images/logo/logo_apollo_pdv.png');
    final Uint8List logo = logoByte.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll57,
        margin: const pw.EdgeInsets.only(left: 8, right: 32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      company.getName(),
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      "${company.getAddress()["street"]},${company.getAddress()["number"]}, B. ${company.getAddress()["neighborhood"]}. ${company.getAddress()["city"]} - ${company.getAddress()["uf"]}",
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(top: 4),
                      child: pw.Text(
                        "Contato: ${company.getPhone()}",
                        style: pw.TextStyle(
                          fontSize: 8,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    ),
                    pw.Text(
                      "CNPJ: ${company.getCNPJ()}",
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                    pw.Text(
                      "Realizada em: ${sale.getSale()["date"]}",
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                  ]),
              pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Divider(thickness: 0.4),
                    pw.Text(
                      "CUPOM NÃO FISCAL",
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                    pw.Divider(thickness: 0.4),
                  ]),
              pw.ListView(
                children: products.map((product) {
                  return pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 6),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          product.getDescription(),
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.normal,
                          ),
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Qtd.: ${product.getAmount()}",
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              "${Formatters().formatMoneyBRL(value: product.getSalePrice())} un.",
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              Formatters()
                                  .formatMoneyBRL(value: product.getTotal()),
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              pw.Divider(thickness: 0.4),
              sale.getSale()["discount"] > 0
                  ? pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              "Subtotal: ${Formatters().formatMoneyBRL(value: sale.getSale()["total"]["totalWithoutDiscount"])}",
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              "Desconto: ${Formatters().formatMoneyBRL(value: sale.getSale()["discount"])}",
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              "TOTAL: ${Formatters().formatMoneyBRL(value: sale.getSale()["total"]["total"])}",
                              style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Column(
                          children: [
                            pw.Text(
                              "TOTAL: ${Formatters().formatMoneyBRL(value: sale.getSale()["total"]["total"])}",
                              style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
              pw.Divider(thickness: 0.4),
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
              pw.SizedBox(
                height: 30,
                child: pw.Text(""),
              ),
               pw.Divider(thickness: 0.4),
            ],
          ); // Center
        },
      ),
    );
    Uint8List pdfToPrint = await pdf.save().then((value) => value);
    PrintTicket(pdf: pdfToPrint);
  }
}
