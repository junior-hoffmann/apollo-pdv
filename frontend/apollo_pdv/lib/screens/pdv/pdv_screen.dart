// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:apollo_pdv/models/product.dart';
import 'package:apollo_pdv/models/product_sold.dart';
import 'package:apollo_pdv/providers/products_provider.dart';
import 'package:apollo_pdv/screens/pdv/finalizar_venda_screen.dart';
import 'package:apollo_pdv/screens/pdv/pesquisar_produtos_screen.dart';
import 'package:apollo_pdv/screens/widgets/input.dart';
import 'package:apollo_pdv/screens/widgets/snackbar.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PdvScreen extends StatefulWidget {
  const PdvScreen({super.key});

  @override
  State<PdvScreen> createState() => _PdvScreenState();
}

class _PdvScreenState extends State<PdvScreen> {
  TextEditingController codeController = TextEditingController();
  FocusNode codeFocus = FocusNode();
  List<ProductSold> selectedProducts = [];
  final AppTheme _theme = AppTheme();
  double total = 0;
  int selectedAmount = 1;

  @override
  Widget build(BuildContext context) {
    final List<Product> products =
        Provider.of<ProductsProvider>(context).products;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: Image.asset(
            "images/logo/logo_apollo_pdv.png",
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: _theme.borderColor),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: codeController,
                      focusNode: codeFocus,
                      onSubmitted: (_) =>
                          selectProduct(products: products, context: context),
                      decoration: InputDecoration(
                        focusedBorder: _theme.inputBorder,
                        enabledBorder: _theme.inputBorder,
                        // prefixIcon: const Icon(Iconsax.scan_barcode),
                        hintText:
                            "Digite o código de barras ou a quantidade...",
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
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
                        onPressed: () async {
                          try {
                            Product produtoSelecionado = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PesquisarProdutosScreen(
                                          products: products,
                                        )));
                            if (produtoSelecionado != null) {
                              selectProductWait(
                                  selectedProduct: produtoSelecionado);
                            }
                            // ignore: empty_catches
                          } catch (e) {}
                        },
                        child: const Text(
                          "Busca avançada",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: DataTable(
                  showCheckboxColumn: false,
                  columns: const [
                    DataColumn(label: Text("Descrição")),
                    DataColumn(label: Text("Qtd.")),
                    DataColumn(label: Text("Valor un.")),
                    DataColumn(label: Text("Total")),
                  ],
                  rows: List.generate(
                    selectedProducts.length,
                    (index) => DataRow(
                      onSelectChanged: (_) =>
                          atualizarProduto(index: index, context: context),
                      color: (index % 2 == 0)
                          ? MaterialStateProperty.resolveWith(
                              _theme.tableRowColor)
                          : null,
                      cells: [
                        DataCell(
                          Text(selectedProducts[index].getDescription()),
                        ),
                        DataCell(
                          Text(selectedProducts[index].getAmount().toString()),
                        ),
                        DataCell(
                          Text(Formatters().formatMoneyBRL(
                              value: selectedProducts[index].getSalePrice())),
                        ),
                        DataCell(
                          Text(Formatters().formatMoneyBRL(
                              value: selectedProducts[index].getTotal())),
                          showEditIcon: true,
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
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // IconButton(onPressed: () {}, icon: const Icon(Iconsax.setting)),
              SizedBox(
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
                  onPressed: () async {
                    if (selectedProducts.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FinalizarVendaScreen(products: selectedProducts),
                        ),
                      ).then((value) {
                        if (value["action"] == "home") {
                          Navigator.pop(context);
                        } else {
                          setState(() {
                            codeController.clear();
                            codeFocus.requestFocus();
                            selectedProducts.clear();
                            total = 0;
                            selectedAmount = 1;
                          });
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        Warnings().snackBar(
                            value: "Adicione algum produto para prosseguir!",
                            backgroundColor: Colors.red,
                            textColor: Colors.white),
                      );
                    }
                  },
                  child: const Text(
                    "Finalizar venda",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Total da venda",
                    style: TextStyle(
                      color: _theme.primaryText,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "R\$",
                        style: TextStyle(
                          color: _theme.primaryText,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        Formatters().formatMoneyBRL(value: total),
                        style: TextStyle(
                          color: _theme.primaryText,
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void atualizarProduto({required int index, required BuildContext context}) {
    TextEditingController controllerEditarQuantidade = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedProducts[index].getDescription()),
            IconButton(
              onPressed: () {
                setState(() {
                  selectedProducts.removeAt(index);
                  sumTotal();
                });
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
            )
          ],
        ),
        content: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SizedBox(
                width: 200,
                child: Input(
                    placeholder: "Nova quantidade",
                    controller: controllerEditarQuantidade,
                    context: context,
                    isNumber: true),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (controllerEditarQuantidade.text.isNotEmpty) {
                      selectedProducts[index].updateAmount(
                          newAmount:
                              int.parse(controllerEditarQuantidade.text));
                      Navigator.pop(context);
                      setState(() {
                        sumTotal();
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _theme.primaryColor,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    shape: ContinuousRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(_theme.borderRadius)),
                  ),
                  child: const Text("Atualizar"),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancelar",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void sumTotal() {
    total = 0;
    for (ProductSold product in selectedProducts) {
      total += product.getTotal();
    }

    setState(() {
      total;
    });
  }

  void resetController() {
    codeController.text = "";
    codeFocus.requestFocus();
  }

  void selectProductWait({required Product selectedProduct}) {
    ProductSold product = ProductSold(
        code: selectedProduct.getCode(),
        description: selectedProduct.getDescription(),
        costPrice: selectedProduct.getCostPrice(),
        barCode: selectedProduct.getBarCode(),
        salePrice: selectedProduct.getSalePrice(),
        amount: selectedAmount);

    setState(() {
      selectedProducts.add(product);
    });
    sumTotal();
    resetController();
    selectedAmount = 1;
  }

  void selectProduct(
      {required List<Product> products,
      required BuildContext context,
      Product? selectedProduct}) {
    try {
      if (codeController.text.length < 4) {
        if (int.tryParse(codeController.text) != null) {
          selectedAmount = int.parse(codeController.text);
          resetController();
          ScaffoldMessenger.of(context).showSnackBar(
            Warnings().snackBar(
              value: "Quantidade atualizada para $selectedAmount itens",
              backgroundColor: _theme.secondaryColor,
              textColor: Colors.white,
            ),
          );
          return;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Quantidade ou código inválidos",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
          resetController();
        }
      } else {
        late Product product;
        for (var p in products) {
          if (p.getBarCode() == codeController.text) {
            product = p;
            break;
          }
        }
        ProductSold productSold = ProductSold(
            code: product.getCode(),
            description: product.getDescription(),
            costPrice: product.getCostPrice(),
            barCode: product.getBarCode(),
            salePrice: product.getSalePrice(),
            amount: selectedAmount);

        setState(() {
          selectedProducts.add(productSold);
        });
        sumTotal();
        resetController();
        selectedAmount = 1;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Código de barras inválido",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      resetController();
    }
  }
}
