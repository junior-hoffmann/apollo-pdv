// // ignore_for_file: must_be_immutable

// import 'package:apollo_pdv/models/company.dart';
// import 'package:apollo_pdv/models/sale.dart';
// import 'package:apollo_pdv/pdfs/sale_ticket.dart';
// import 'package:flutter/material.dart';
// import 'package:printing/printing.dart';

// class TesteScreen extends StatefulWidget {
//   Sale sale;
//   Company company = Company(
//       name: "JR Informática",
//       address: {
//         "street": "Rua Tristão de Oliveira",
//         "number": "759",
//         "neighborhood": "Floresta",
//         "city": "Gramado",
//         "uf": "RS",
//       },
//       cnpj: "12.123.321/0001-69",
//       phone: "(54) 9 9682 - 1658");

//   TesteScreen({super.key, required this.sale});

//   @override
//   State<TesteScreen> createState() => _TesteScreenState();
// }

// class _TesteScreenState extends State<TesteScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Gerador de ticket"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: PdfPreview(
//             dpi: 600,
//             build: (format) =>
//                 SaleTicket(sale: widget.sale, company: widget.company).getPdf(),
//           ),
//         ),
//       ),
//     );
//   }
// }
