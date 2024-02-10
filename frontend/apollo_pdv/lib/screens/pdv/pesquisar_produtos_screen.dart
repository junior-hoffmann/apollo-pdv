// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/product.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';

class PesquisarProdutosScreen extends StatefulWidget {
  List<Product> products;

  PesquisarProdutosScreen({required this.products, Key? key}) : super(key: key);

  @override
  State<PesquisarProdutosScreen> createState() =>
      _PesquisarProdutosScreenState();
}

class _PesquisarProdutosScreenState extends State<PesquisarProdutosScreen> {
  TextEditingController nomeController = TextEditingController();
  final AppTheme _theme = AppTheme();
  late List<Product> productsFiltered;

  @override
  void initState() {
    super.initState();
    productsFiltered = List.from(widget.products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Busca avançada",
          style: TextStyle(color: _theme.primaryText),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 32, right: 32, top: 8),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - (64),
                                  child: TextField(
                                    controller: nomeController,
                                    onChanged: (value) => filter(filterWord: value),
                                    decoration: const InputDecoration(
                                      labelText:
                                          "Digite o código de barras ou a descrição",
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: DataTable(
                        showCheckboxColumn: false,
                        columns: const [
                          DataColumn(label: Text("Cód.")),
                          DataColumn(label: Text("Cód. de barras")),
                          DataColumn(label: Text("Descrição")),
                          DataColumn(label: Text("Preço de venda")),
                        ],
                        rows: List.generate(
                          productsFiltered.length,
                          (index) => DataRow(
                            onSelectChanged: (_) {
                              Navigator.pop(context, productsFiltered[index]);
                            },
                            cells: [
                              DataCell(
                                Text(productsFiltered[index].getCode()),
                              ),
                              DataCell(
                                Text(productsFiltered[index].getBarCode()),
                              ),
                              DataCell(
                                Text(productsFiltered[index].getDescription()),
                              ),
                              DataCell(
                                Text(Formatters().formatMoneyBRL(
                                    value: productsFiltered[index].getSalePrice())),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void filter({required String filterWord}) {
    final suggestions = widget.products.where((product) {
      final name = product.getDescription().toLowerCase();
      final barCode = product.getBarCode();
      final input = filterWord.toLowerCase();
      final wordsOnName = name.split(' ');
      final code = product.getCode().toLowerCase();

      return wordsOnName.any((word) => word.startsWith(input)) ||
          barCode.contains(input) ||
          code == input;
    }).toList();

    suggestions.sort((a, b) {
      final codeA = a.getCode().toLowerCase();
      final codeB = b.getCode().toLowerCase();
      return codeA == filterWord ? -1 : (codeB == filterWord ? 1 : 0);
    });

    setState(() {
      productsFiltered = List.from(suggestions);
    });
  }
}
