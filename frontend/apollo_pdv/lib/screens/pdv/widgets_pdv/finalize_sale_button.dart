// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/product_sold.dart';
import 'package:apollo_pdv/models/sale.dart';
import 'package:apollo_pdv/providers/sales_provider.dart';
import 'package:apollo_pdv/screens/pdv/venda_finalizada_screen.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinalizeSaleButton extends StatelessWidget {
  FinalizeSaleButton({
    super.key,
    required this.products,
    required this.moneyController,
    required this.creditController,
    required this.debitController,
    required this.pixController,
    required this.checkController,
    required this.discount,
  });
  final AppTheme _theme = AppTheme();
  List<ProductSold> products;
  TextEditingController moneyController;
  TextEditingController creditController;
  TextEditingController debitController;
  TextEditingController pixController;
  TextEditingController checkController;
  double discount;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Sale sale = Sale(
          date: DateTime.now(),
          products: products,
          discount: discount,
          paymentForm: {
            "money": double.tryParse(moneyController.text) != null
                ? double.parse(moneyController.text)
                : 0,
            "creditCard": double.tryParse(creditController.text) != null
                ? double.parse(creditController.text)
                : 0,
            "debitCard": double.tryParse(debitController.text) != null
                ? double.parse(debitController.text)
                : 0,
            "pix": double.tryParse(pixController.text) != null
                ? double.parse(pixController.text)
                : 0,
            "check": double.tryParse(checkController.text) != null
                ? double.parse(checkController.text)
                : 0,
          },
        );

        Provider.of<SalesProvider>(context, listen: false)
            .setNewSale(sale: sale)
            .then((value) {
          if (value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VendaFinalizadaScreen(),
                )).then((value) {
              if (value) {
                Navigator.pop(context, true);
              }
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 2),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Houve um erro ao finalizar a venda",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                backgroundColor: Colors.red,
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
            borderRadius: BorderRadius.circular(_theme.borderRadius)),
      ),
      child: const Text("Finalizar venda"),
    );
  }
}
