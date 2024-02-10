// ignore_for_file: must_be_immutable
import 'package:apollo_pdv/models/product.dart';
import 'package:apollo_pdv/providers/products_provider.dart';
import 'package:apollo_pdv/screens/widgets/input.dart';
import 'package:apollo_pdv/screens/widgets/snackbar.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewProductScreen extends StatefulWidget {
  NewProductScreen({super.key});

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController barCodeController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController costPriceController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
}

class _NewProductScreenState extends State<NewProductScreen> {
  final AppTheme _theme = AppTheme();

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
                "Novo produto",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Input(
                      placeholder: "Descrição",
                      controller: widget.descriptionController,
                      context: context,
                      isNumber: false,
                    ),
                  ),
                ),
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
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _theme.primaryColor,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(_theme.borderRadius)),
                ),
                onPressed: () {
                  try {
                    Product newProduct = Product(
                      description: widget.descriptionController.text,
                      barCode: widget.barCodeController.text,
                      code: widget.codeController.text,
                      costPrice: double.parse(widget.costPriceController.text),
                      salePrice: double.parse(widget.salePriceController.text),
                      stock: int.parse(widget.stockController.text),
                    );
                    provider.setProduct(product: newProduct).then((value) {
                      Navigator.pop(context, value);
                    });
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
                  "Salvar produto",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
