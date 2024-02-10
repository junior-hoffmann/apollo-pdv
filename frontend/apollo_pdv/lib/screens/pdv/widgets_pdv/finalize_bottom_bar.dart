// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:apollo_pdv/models/product_sold.dart';
import 'package:apollo_pdv/screens/pdv/widgets_pdv/finalize_sale_button.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FinalizeBottonBar extends StatelessWidget {
  FinalizeBottonBar({
    super.key,
    required this.total,
    required this.products,
    required this.moneyController,
    required this.creditController,
    required this.debitController,
    required this.pixController,
    required this.checkController,
    required this.discount,
  });

  TextEditingController moneyController;
  TextEditingController creditController;
  TextEditingController debitController;
  TextEditingController pixController;
  TextEditingController checkController;
  List<ProductSold> products;
  double total;
  double discount;

  final AppTheme _theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          child: SvgPicture.asset(
            "images/rodape.svg",
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            color: _theme.backgroundColor,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              total == 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: FinalizeSaleButton(
                              products: products,
                              moneyController: moneyController,
                              creditController: creditController,
                              debitController: debitController,
                              pixController: pixController,
                              checkController: checkController,
                              discount: discount,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              total > 0 ? "Falta" : "Troco",
                              style: TextStyle(
                                color: total > 0
                                    ? Colors.redAccent
                                    : _theme.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
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
                                    color: total > 0
                                        ? Colors.redAccent
                                        : _theme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  Formatters().formatMoneyBRLNoSimbol(
                                      value: total.abs()),
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                    color: total > 0
                                        ? Colors.redAccent
                                        : _theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
