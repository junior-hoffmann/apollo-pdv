// import 'dart:typed_data';
// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:apollo_pdv/models/product_sold.dart';
import 'package:apollo_pdv/models/report.dart';
import 'package:apollo_pdv/screens/widgets/snackbar.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ReportSheet {
  Report report;
  var excel = Excel.createExcel();

  ReportSheet({required this.report});

  Future<void> getSheet({required BuildContext context}) async {
    Sheet sheetObject = excel['Sheet1'];
    List<ProductSold> products = report.getSaledProducts();

    sheetObject.appendRow([
      const TextCellValue("Código de barras"),
      const TextCellValue("Descrição"),
      const TextCellValue("Preço de custo"),
      const TextCellValue("Qtd."),
      const TextCellValue("Preço de venda"),
    ]);

    for (ProductSold product in products) {
      sheetObject.appendRow([
        TextCellValue(product.getBarCode()),
        TextCellValue(product.getDescription()),
        TextCellValue(product.getCostPrice().toString()),
        TextCellValue(product.getAmount().toString()),
        TextCellValue(product.getSalePrice().toString()),
      ]);
    }

    try {
      String? result = await FilePicker.platform.getDirectoryPath();
      if (result != null) {
        String path = '$result/produtos-vendidos.xlsx';
        var bytes = excel.encode();
        await File(path).writeAsBytes(bytes!);
        ScaffoldMessenger.of(context).showSnackBar(
          Warnings().snackBar(
            value: "Salvo com sucesso!",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          ),
        );
      }
    } catch (_) {}
  }
}
