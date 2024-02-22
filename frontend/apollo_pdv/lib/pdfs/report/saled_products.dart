import 'package:apollo_pdv/models/product_sold.dart';
import 'package:apollo_pdv/models/report.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SaledProducts {
  late Report _report;

  SaledProducts({required Report report}) {
    _report = report;
  }

  final Map<int, pw.TableColumnWidth> _columnWidths = const {
    0: pw.FractionColumnWidth(PdfPageFormat.cm * 2.5),
    1: pw.FractionColumnWidth(PdfPageFormat.cm * 3.5),
    2: pw.FractionColumnWidth(PdfPageFormat.cm * 1.2),
    3: pw.FractionColumnWidth(PdfPageFormat.cm * 2.5),
    4: pw.FractionColumnWidth(PdfPageFormat.cm * 2.5),
  };

  final List<pw.Widget> _sumary = [
    pw.Padding(
      padding: const pw.EdgeInsets.only(top: 12),
      child: pw.Divider(thickness: 0.4),
    ),
    pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Text(
        "ITENS VENDIDOS",
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    ),
  ];

  List<pw.Widget> get() {
    _addHeader();
    List<ProductSold> products = _report.getSaledProducts();

    for (ProductSold product in products) {
      double cost = product.getCostPrice() * product.getAmount();
      double profit =
          product.getTotal() - (product.getCostPrice() * product.getAmount());

      _sumary.add(
        pw.TableHelper.fromTextArray(
          columnWidths: _columnWidths,
          data: [
            [
              product.getBarCode(),
              product.getDescription(),
              product.getAmount(),
              Formatters().formatMoneyBRL(value: cost),
              Formatters().formatMoneyBRL(value: profit),
            ]
          ],
        ),
      );
    }
    return _sumary;
  }

  void _addHeader() {
    _sumary.add(
      pw.TableHelper.fromTextArray(
        data: [],
        columnWidths: _columnWidths,
        headerDecoration: pw.BoxDecoration(
          color: PdfColor.fromHex("8cb4ff"),
        ),
        headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        headers: [
          "Código de barras",
          "Descrição",
          "Qtd.",
          "Custo",
          "Lucro"
        ],
      ),
    );
  }
}
