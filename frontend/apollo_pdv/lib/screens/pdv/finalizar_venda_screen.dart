// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:apollo_pdv/models/product_sold.dart';
import 'package:apollo_pdv/screens/pdv/widgets_pdv/discount_button.dart';
import 'package:apollo_pdv/screens/pdv/widgets_pdv/discount_text.dart';
import 'package:apollo_pdv/screens/pdv/widgets_pdv/finalize_bottom_bar.dart';
import 'package:apollo_pdv/screens/pdv/widgets_pdv/payment_form.dart';
import 'package:apollo_pdv/screens/pdv/widgets_pdv/total_text.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';

class FinalizarVendaScreen extends StatefulWidget {
  List<ProductSold> products;
  FinalizarVendaScreen({required this.products, super.key}) {
    total = 0;
    for (ProductSold produto in products) {
      total += produto.getTotal();
    }
    totalSell = total;
  }

  TextEditingController moneyController = TextEditingController();
  TextEditingController creditController = TextEditingController();
  TextEditingController debitController = TextEditingController();
  TextEditingController pixController = TextEditingController();
  TextEditingController checkController = TextEditingController();
  double total = 0;
  double totalSell = 0;
  double discount = 0;

  @override
  State<FinalizarVendaScreen> createState() => _FinalizarVendaScreenState();
}

class _FinalizarVendaScreenState extends State<FinalizarVendaScreen> {
  final AppTheme _theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // foregroundColor: _padroes.corPrimaria,
        backgroundColor: Colors.white,
        title: SizedBox(
          height: 40,
          child: Image.asset(
            "images/logo/logo_apollo_pdv.png",
          ),
        ),
        actions: [
          DiscountButton(
            mainContext: context,
            onClick: setDiscount,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TotalText(
                  text: "Total a pagar",
                  total: widget.totalSell - widget.discount,
                  fontSize: 24,
                  textColor: _theme.primaryText,
                ),
                DiscountText(
                    discount: widget.discount, total: widget.totalSell),
                PaymentForm(
                  moneyController: widget.moneyController,
                  creditController: widget.creditController,
                  debitController: widget.debitController,
                  pixController: widget.pixController,
                  checkController: widget.checkController,
                  mainContext: context,
                  onChanged: () {
                    sumTotal(context: context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FinalizeBottonBar(
        discount: widget.discount,
        total: widget.total,
        products: widget.products,
        moneyController: widget.moneyController,
        creditController: widget.creditController,
        debitController: widget.debitController,
        pixController: widget.pixController,
        checkController: widget.checkController,
      ),
    );
  }

  void sumPayment({required BuildContext context}) {
    double dinheiro = widget.moneyController.text.isEmpty
        ? 0
        : double.parse(widget.moneyController.text);

    double cartaoDeCredito = widget.creditController.text.isEmpty
        ? 0
        : double.parse(widget.creditController.text);

    double cartaodeDebito = widget.debitController.text.isEmpty
        ? 0
        : double.parse(widget.debitController.text);

    double pix = widget.pixController.text.isEmpty
        ? 0
        : double.parse(widget.pixController.text);

    double cheque = widget.checkController.text.isEmpty
        ? 0
        : double.parse(widget.checkController.text);

    setState(() {
      if (dinheiro > 0) {
        widget.total -= dinheiro;
      }

      if (cartaoDeCredito > 0) {
        widget.total -= cartaoDeCredito;
      }

      if (cartaodeDebito > 0) {
        widget.total -= cartaodeDebito;
      }

      if (pix > 0) {
        widget.total -= pix;
      }

      if (cheque > 0) {
        widget.total -= cheque;
      }
    });
  }

  void setDiscount({required double discount, required BuildContext context}) {
    if (discount > 0 && discount <= 100) {
      widget.discount = widget.total * (discount / 100);
      widget.total -= widget.discount;
    } else {
      widget.discount = 0;
      widget.total = widget.totalSell;
    }
    setState(() {
      sumTotal(context: context);
    });
  }

  void sumTotal({
    required BuildContext context,
  }) {
    widget.total = 0;

    for (ProductSold produto in widget.products) {
      widget.total += produto.getTotal();
    }

    if (widget.discount > 0) {
      widget.total -= widget.discount;
    }

    sumPayment(
      context: context,
    );
  }
}
