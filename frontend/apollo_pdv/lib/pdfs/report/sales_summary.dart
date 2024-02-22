import 'package:apollo_pdv/models/sale.dart';
import 'package:apollo_pdv/pdfs/report/utils_report.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SalesSummary {
  late List<Sale> _sales;

  SalesSummary({required List<Sale> sales}) {
    _sales = sales;
  }

  final List<pw.Widget> _sumary = [
    pw.Divider(thickness: 0.4),
    pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Text(
        "VENDAS",
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    ),
    pw.TableHelper.fromTextArray(
      data: [],
      columnWidths: const {
        0: pw.FractionColumnWidth(PdfPageFormat.cm * 2.5),
        1: pw.FractionColumnWidth(PdfPageFormat.cm * 1.5),
        2: pw.FractionColumnWidth(PdfPageFormat.cm * 3),
        3: pw.FractionColumnWidth(PdfPageFormat.cm * 2.5),
        4: pw.FractionColumnWidth(PdfPageFormat.cm * 2.5),
      },
      headerDecoration: pw.BoxDecoration(
        color: PdfColor.fromHex("8cb4ff"),
      ),
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headers: [
        "Data e hora",
        "Itens",
        "Forma de pagamento",
        "Total da venda",
        "Lucro"
      ],
    ),
  ];

  List<pw.Widget> get() {
    for (Sale sale in _sales) {
      _sumary.add(
        pw.TableHelper.fromTextArray(
          columnWidths: const {
            0: pw.FractionColumnWidth(PdfPageFormat.cm * 2.5),
            1: pw.FractionColumnWidth(PdfPageFormat.cm * 1.5),
            2: pw.FractionColumnWidth(PdfPageFormat.cm * 3),
            3: pw.FractionColumnWidth(PdfPageFormat.cm * 2.5),
            4: pw.FractionColumnWidth(PdfPageFormat.cm * 2.5),
          },
          data: [
            [
              sale.getSale()["date"],
              UtilsReport().sumItens(products: sale.getSale()["products"]),
              UtilsReport()
                  .paymentForm(paymentForm: sale.getSale()["paymentForm"]),
              Formatters()
                  .formatMoneyBRL(value: sale.getSale()["total"]["total"]),
              Formatters().formatMoneyBRL(value: sale.getSale()["profit"]),
            ]
          ],
        ),
      );
    }
    return _sumary;
  }
}
