// ignore_for_file: must_be_immutable
import 'package:apollo_pdv/models/product.dart';
import 'package:apollo_pdv/providers/products_provider.dart';
import 'package:apollo_pdv/screens/widgets/input.dart';
import 'package:apollo_pdv/screens/widgets/snackbar.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  EditProductScreen({super.key, required this.product});

  Product product;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController barCodeController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController costPriceController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final AppTheme _theme = AppTheme();

  @override
  void initState() {
    super.initState();
    widget.descriptionController.text = widget.product.getDescription();
    widget.codeController.text = widget.product.getCode();
    widget.barCodeController.text = widget.product.getBarCode();
    widget.stockController.text = widget.product.getStock().toString();
    widget.costPriceController.text = widget.product.getCostPrice().toString();
    widget.salePriceController.text = widget.product.getSalePrice().toString();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: SizedBox(
          height: 40,
          child: Image.asset(
            "images/logo/logo_apollo_pdv.png",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 40),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Text(
                "Editar produto",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Input(
                    placeholder: "Descrição",
                    controller: widget.descriptionController,
                    context: context,
                    isNumber: false,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Input(
                    placeholder: "Código de barras",
                    controller: widget.barCodeController,
                    context: context,
                    isNumber: false,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Input(
                      placeholder: "Código interno",
                      controller: widget.codeController,
                      context: context,
                      isNumber: false,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Input(
                      placeholder: "Estoque",
                      controller: widget.stockController,
                      context: context,
                      isNumber: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Input(
                      placeholder: "Preço de custo",
                      controller: widget.costPriceController,
                      context: context,
                      isNumber: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Input(
                      placeholder: "Preço de venda",
                      controller: widget.salePriceController,
                      context: context,
                      isNumber: true,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      shape: ContinuousRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(_theme.borderRadius)),
                    ),
                    onLongPress: () {
                      provider
                          .deleteProduct(id: widget.product.getId())
                          .then((value) => Navigator.pop(context, value));
                    },
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Segure pressionado o botão ”Excluir produto” para excluí-lo",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    child: const Text(
                      "Excluir produto",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: ContinuousRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(_theme.borderRadius)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _theme.primaryColor,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: ContinuousRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(_theme.borderRadius)),
                      ),
                      onPressed: () {
                        try {
                          widget.product.setDescription(
                              description:
                                  widget.descriptionController.text.toString());

                          widget.product.setBarCode(
                              barCode:
                                  widget.barCodeController.text.toString());

                          widget.product.setCode(
                              code: widget.codeController.text.toString());

                          widget.product.setCostPrice(
                              costPrice: double.parse(
                                  widget.costPriceController.text));
                          widget.product.setSalePrice(
                              salePrice: double.parse(
                                  widget.salePriceController.text));
                          widget.product.setStock(
                              amount: int.parse(widget.stockController.text));
                          provider
                              .updateProduct(
                                  product: widget.product,
                                  id: widget.product.getId())
                              .then((value) => Navigator.pop(context, value));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            Warnings().snackBar(
                                value: "Preencha todos os campos!",
                                backgroundColor: Colors.red,
                                textColor: Colors.white),
                          );
                        }
                      },
                      child: const Text(
                        "Salvar alterações",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
