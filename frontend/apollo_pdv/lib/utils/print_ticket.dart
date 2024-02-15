import 'dart:typed_data';

import 'package:printing/printing.dart';

class PrintTicket{

  Uint8List pdf;


  PrintTicket({required this.pdf}){
    _print();
  }

  void _print() async{
    Printer printer = const Printer(url: "apollopdvprinter");
    await Printing.directPrintPdf(printer: printer, onLayout: (format) => pdf,);
  }

}