// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/product.dart';
import 'package:apollo_pdv/providers/products_provider.dart';
import 'package:apollo_pdv/screens/products/new_product_screen.dart';
import 'package:apollo_pdv/screens/widgets/title_row.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsHeader extends StatefulWidget {
  ProductsHeader(
      {super.key,
      required this.productsFiltered,
      required this.nameController,
      required this.filter});
  late List<Product> productsFiltered;
  TextEditingController nameController;
  Function filter;

  @override
  State<ProductsHeader> createState() => _ProductsHeaderState();
}

class _ProductsHeaderState extends State<ProductsHeader> {
  final AppTheme _theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _theme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            const TitleRow(
              title: "Produtos",
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: TextField(
                        controller: widget.nameController,
                        onChanged: (value) => widget.filter(filterWord: value),
                        decoration: const InputDecoration(
                          labelText: "Digite o código de barras ou a descrição",
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewProductScreen(),
                            ),
                          ).then((value) {
                            setState(() {
                              widget.productsFiltered =
                                  Provider.of<ProductsProvider>(context,
                                          listen: false)
                                      .products;
                            });
                            if (value != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 2),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        value,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: _theme.primaryColor,
                                ),
                              );
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _theme.primaryColor,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: ContinuousRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(_theme.borderRadius)),
                        ),
                        child: const Text("Novo Produto"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
