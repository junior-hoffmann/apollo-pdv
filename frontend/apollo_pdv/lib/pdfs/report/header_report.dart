import 'package:apollo_pdv/models/company.dart';
import 'package:pdf/widgets.dart' as pw;

class HeaderReport {
  List<pw.Widget> get({required Company company}) {
    return [
      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(
          company.getName(),
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          "${company.getAddress()["street"]},${company.getAddress()["number"]}, B. ${company.getAddress()["neighborhood"]}. ${company.getAddress()["city"]} - ${company.getAddress()["uf"]}",
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.normal,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 4),
          child: pw.Text(
            "Contato: ${company.getPhone()}",
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.normal,
            ),
          ),
        ),
        pw.Text(
          "CNPJ: ${company.getCNPJ()}",
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.normal,
          ),
        ),
      ])
    ];
  }
}
