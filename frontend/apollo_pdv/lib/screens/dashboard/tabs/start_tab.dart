// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/models/task.dart';
import 'package:apollo_pdv/providers/products_provider.dart';
import 'package:apollo_pdv/screens/dashboard/money_calculator_screen.dart';
import 'package:apollo_pdv/screens/pdv/pdv_screen.dart';
import 'package:apollo_pdv/screens/reports/fast_report_screen.dart';
import 'package:apollo_pdv/screens/widgets/input.dart';
import 'package:apollo_pdv/screens/widgets/postit_card.dart';
import 'package:apollo_pdv/screens/widgets/snackbar.dart';
import 'package:apollo_pdv/screens/widgets/square_button.dart';
import 'package:apollo_pdv/screens/widgets/title_row.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartTab extends StatelessWidget {
  StartTab({super.key, required this.tasks});
  List<Task> tasks;
  final AppTheme _theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    double size = ((MediaQuery.of(context).size.width / 4) - 40);
// ((MediaQuery.of(context).size.width / 4) - 40)
    return Expanded(
      child: Container(
        color: _theme.secondaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  const TitleRow(
                    title: "Início",
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SquareButton(
                          size: size,
                          title: "Nova venda",
                          urlImage: "images/icons/comprar-online.png",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PdvScreen(),
                              ),
                            );
                          },
                        ),
                        SquareButton(
                            size: size,
                            title: "Calculadora de caixa",
                            urlImage: "images/icons/calculadora.png",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MoneyCalculatorScreen(),
                                ),
                              );
                            }),
                        SquareButton(
                          size: size,
                          title: "Atualizar estoque",
                          urlImage: "images/icons/atualizar-estoque.png",
                          onTap: () {
                            TextEditingController skuController =
                                TextEditingController();
                            TextEditingController amountController =
                                TextEditingController();
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Input(
                                          placeholder: "Código de barras",
                                          controller: skuController,
                                          context: context,
                                          isNumber: true),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: SizedBox(
                                        width: 100,
                                        child: Input(
                                            placeholder: "Qtd.",
                                            controller: amountController,
                                            context: context,
                                            isNumber: true),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          try {
                                            Provider.of<ProductsProvider>(
                                                    context,
                                                    listen: false)
                                                .setStock(
                                                    barCode: skuController.text,
                                                    amount: int.parse(
                                                        amountController.text))
                                                .then((value) => Navigator.pop(
                                                    context, value));
                                          } catch (error) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: _theme.primaryColor,
                                          shadowColor: Colors.transparent,
                                          elevation: 0,
                                          shape: ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      _theme.borderRadius)),
                                        ),
                                        child: const Text("Atualizar"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ).then((value) {
                              if (value != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    Warnings().snackBar(
                                        value: value,
                                        backgroundColor: _theme.secondaryColor,
                                        textColor: Colors.white));
                              }
                            });
                          },
                        ),
                        SquareButton(
                          size: size,
                          title: "Relatório rápido",
                          urlImage: "images/icons/relatorio.png",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FastReportScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const TitleRow(
                title: "Tarefas para hoje",
                color: Colors.white,
              ),
              tasks.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child:
                                  Image.asset("images/icons/pasta-vazia.png"),
                            ),
                            Text(
                              "Você está sem lembretes",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                        left: 32,
                        right: 32,
                        bottom: 8,
                        top: 8,
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.only(top: 10),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: tasks.length,
                        itemBuilder: (BuildContext context, int index) =>
                            PostitCard(task: tasks[index]),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
