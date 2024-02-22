// import 'dart:typed_data';
import 'dart:io';

import 'package:apollo_pdv/models/company.dart';
import 'package:apollo_pdv/models/product_sold.dart';
import 'package:apollo_pdv/models/report.dart';
import 'package:apollo_pdv/models/sale.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

class ReportSheet {
  Report report;
  Company company;

  ReportSheet({required this.report, required this.company});

  void getSheeta() async {
  print("Criando...");

  var excel = Excel.createExcel();
  Sheet sheet = excel["Vendas"];
  var cell =
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1));
  cell.value = const TextCellValue(
      "Testei a criação de um bagulhete desses");

  // Use o file_picker para obter o diretório onde o arquivo será salvo
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx'], // Permite apenas a seleção de arquivos do tipo xlsx
    dialogTitle: 'Salvar Planilha', // Título da janela de seleção de arquivo
  );

  if (result != null) {
    String? path = result.files.single.path; // Caminho onde o arquivo será salvo
    // if (path != null) {
    //   excel.encode().then((onValue) {
    //     File(path)
    //       ..createSync(recursive: true)
    //       ..writeAsBytesSync(onValue);
    //     print("Planilha salva em: $path");
    //   });
    // } else {
    //   print('Nenhum arquivo selecionado');
    // }
  } else {
    print('Nenhum arquivo selecionado');
  }
}

void getSheet() {
  print("Criando...");

  var excel = Excel.createExcel();
  Sheet sheet = excel["Vendas"];
  var cell =
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1));
  cell.value = const TextCellValue(
      "Testei a criação de um bagulhete desses");

  // Caminho onde o arquivo será salvo (exemplo: pasta de documentos do usuário)
  String savePath = '${Directory.current.path}\\Planilhas'; // Exemplo de caminho
  
  // Verifica se o diretório de destino existe, caso contrário, cria
  // Directory(savePath).createSync(recursive: true);

  String filePath = '$savePath\\Teste_de_venda.xlsx'; // Caminho completo do arquivo

  var fileBytes = excel.save();

  // Salva o arquivo Excel
  // File(filePath).writeAsBytesSync(excel.encode()!);
  File(filePath)
  ..createSync(recursive: true)
  ..writeAsBytesSync(fileBytes!);
  print("Planilha salva em: $filePath");
}

  void getSheet1() {
    print("Criando...");
    var excel = Excel.createExcel();
    // excel.rename(excel.getDefaultSheet()!, "Vendas");
    Sheet sheet = excel["Vendas"];
    var cell =
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1));
    cell.value = const TextCellValue("Testei a criação de um bagulhete desses");
    excel.save(fileName: "Teste de venda.xlsx");
    
  }

  String _sumItens({required List<ProductSold> products}) {
    int itensAmount = 0;
    for (ProductSold product in products) {
      itensAmount += product.getAmount();
    }
    return itensAmount.toString();
  }

  String paymentForm({required Map<String, dynamic> paymentForm}) {
    List<String> methods = [];

    if (paymentForm.containsKey("money") && paymentForm["money"] > 0) {
      methods.add("Dinheiro");
    }
    if (paymentForm.containsKey("creditCard") &&
        paymentForm["creditCard"] > 0) {
      methods.add("Cartão de Crédito");
    }
    if (paymentForm.containsKey("debitCard") && paymentForm["debitCard"] > 0) {
      methods.add("Cartão de Débito");
    }
    if (paymentForm.containsKey("pix") && paymentForm["pix"] > 0) {
      methods.add("Pix");
    }
    if (paymentForm.containsKey("check") && paymentForm["check"] > 0) {
      methods.add("Cheque");
    }

    if (methods.isEmpty) {
      return "Sem informações de pagamento";
    } else {
      return methods.join(' e ');
    }
  }
}
