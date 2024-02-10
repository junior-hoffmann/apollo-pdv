// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/product.dart';
import 'package:apollo_pdv/providers/products_provider.dart';
import 'package:apollo_pdv/screens/products/edit_product_screen.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsTable extends StatefulWidget {
  ProductsTable({
    super.key,
    required this.fontSize,
    required this.productsFiltered,
  });

  List<Product> productsFiltered;
  double fontSize;

  @override
  State<ProductsTable> createState() => _ProductsTableState();
}

class _ProductsTableState extends State<ProductsTable> {
  final AppTheme _theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: DataTable(
          columnSpacing: 20,
          showCheckboxColumn: false,
          columns: [
            DataColumn(
                label: Text(
              "Cód.",
              style: TextStyle(
                fontSize: widget.fontSize,
              ),
            )),
            DataColumn(
                label: Text(
              "Cód. de barras",
              style: TextStyle(
                fontSize: widget.fontSize,
              ),
            )),
            DataColumn(
                label: Text(
              "Descrição",
              style: TextStyle(
                fontSize: widget.fontSize,
              ),
            )),
            DataColumn(
                label: Text(
              "Estoque",
              style: TextStyle(
                fontSize: widget.fontSize,
              ),
            )),
            DataColumn(
                label: Text(
              "Preço de custo",
              style: TextStyle(
                fontSize: widget.fontSize,
              ),
            )),
            DataColumn(
                label: Text(
              "Preço de venda",
              style: TextStyle(
                fontSize: widget.fontSize,
              ),
            )),
          ],
          rows: List.generate(
            widget.productsFiltered.length,
            (index) => DataRow(
              onSelectChanged: (_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProductScreen(
                      product: widget.productsFiltered[index],
                    ),
                  ),
                ).then((value) {
                  if (value != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$value",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        backgroundColor: _theme.primaryColor,
                      ),
                    );
                    setState(() {
                      widget.productsFiltered =
                          Provider.of<ProductsProvider>(context,
                                  listen: false)
                              .products;
                    });
                  }
                });
              },
              cells: [
                DataCell(
                  Text(
                    widget.productsFiltered[index].getCode(),
                    style: TextStyle(
                      fontSize: widget.fontSize,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    widget.productsFiltered[index].getBarCode(),
                    style: TextStyle(
                      fontSize: widget.fontSize,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    widget.productsFiltered[index].getDescription(),
                    style: TextStyle(
                      fontSize: widget.fontSize,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    widget.productsFiltered[index].getStock().toString(),
                    style: TextStyle(
                      fontSize: widget.fontSize,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    Formatters().formatMoneyBRL(
                        value:
                            widget.productsFiltered[index].getCostPrice()),
                    style: TextStyle(
                      fontSize: widget.fontSize,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    Formatters().formatMoneyBRL(
                        value:
                            widget.productsFiltered[index].getSalePrice()),
                    style: TextStyle(
                      fontSize: widget.fontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
