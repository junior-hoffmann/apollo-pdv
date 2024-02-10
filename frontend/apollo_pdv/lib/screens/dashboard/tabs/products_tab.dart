// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/product.dart';
import 'package:apollo_pdv/screens/dashboard/tabs/widgets_tabs/products_header.dart';
import 'package:apollo_pdv/screens/dashboard/tabs/widgets_tabs/products_table.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';

class ProductsTab extends StatefulWidget {
  List<Product> products;

  ProductsTab({required this.products, Key? key}) : super(key: key);

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  TextEditingController nameController = TextEditingController();
  final AppTheme _theme = AppTheme();
  late List<Product> productsFiltered;

  @override
  void initState() {
    super.initState();
    productsFiltered = List.from(widget.products);
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * _theme.tableFontSize;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProductsHeader(
                productsFiltered: productsFiltered,
                nameController: nameController,
                filter: filter),
            ProductsTable(
              fontSize: fontSize,
              productsFiltered: productsFiltered,
            ),
          ],
        ),
      ),
    );
  }

  void filter({required String filterWord}) {
    final suggestions = widget.products.where((product) {
      final description = product.getDescription().toLowerCase();
      final barCode = product.getBarCode();
      final input = filterWord.toLowerCase();
      final wordsOnName = description.split(' ');
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
