// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/screens/widgets/input_icon.dart';
import 'package:apollo_pdv/screens/widgets/title_row.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';

class MoneyCalculatorScreen extends StatefulWidget {
  MoneyCalculatorScreen({super.key});

  TextEditingController cents5Controller = TextEditingController();
  TextEditingController cents10Controller = TextEditingController();
  TextEditingController cents25Controller = TextEditingController();
  TextEditingController cents50Controller = TextEditingController();
  TextEditingController real1Controller = TextEditingController();
  TextEditingController real2Controller = TextEditingController();
  TextEditingController real5Controller = TextEditingController();
  TextEditingController real10Controller = TextEditingController();
  TextEditingController real20Controller = TextEditingController();
  TextEditingController real50Controller = TextEditingController();
  TextEditingController real100Controller = TextEditingController();
  TextEditingController real200Controller = TextEditingController();

  double total = 0;

  @override
  State<MoneyCalculatorScreen> createState() => _MoneyCalculatorScreenState();
}

class _MoneyCalculatorScreenState extends State<MoneyCalculatorScreen> {
  final AppTheme _theme = AppTheme();

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleRow(title: "Calculadora de Caixa", color: _theme.primaryText),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      children: [
                        InputIcon(
                          placeholder: "5 centavos",
                          controller: widget.cents5Controller,
                          context: context,
                          isNumber: true,
                          icon: "images/coins/5_centavos.png",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 16),
                          child: InputIcon(
                            placeholder: "10 centavos",
                            controller: widget.cents10Controller,
                            context: context,
                            isNumber: true,
                            icon: "images/coins/10_centavos.png",
                          ),
                        ),
                        InputIcon(
                          placeholder: "25 centavos",
                          controller: widget.cents25Controller,
                          context: context,
                          isNumber: true,
                          icon: "images/coins/25_centavos.png",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 16),
                          child: InputIcon(
                            placeholder: "50 centavos",
                            controller: widget.cents50Controller,
                            context: context,
                            isNumber: true,
                            icon: "images/coins/50_centavos.png",
                          ),
                        ),
                        InputIcon(
                          placeholder: "1 real",
                          controller: widget.real1Controller,
                          context: context,
                          isNumber: true,
                          icon: "images/coins/1_real.png",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      children: [
                        InputIcon(
                          placeholder: "2 reais",
                          controller: widget.real2Controller,
                          context: context,
                          isNumber: true,
                          icon: "images/coins/2_reais.jpg",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 16),
                          child: InputIcon(
                            placeholder: "5 reais",
                            controller: widget.real5Controller,
                            context: context,
                            isNumber: true,
                            icon: "images/coins/5_reais.jpg",
                          ),
                        ),
                        InputIcon(
                          placeholder: "10 reais",
                          controller: widget.real10Controller,
                          context: context,
                          isNumber: true,
                          icon: "images/coins/10_reais.jpg",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 16),
                          child: InputIcon(
                            placeholder: "20 reais",
                            controller: widget.real20Controller,
                            context: context,
                            isNumber: true,
                            icon: "images/coins/20_reais.jpg",
                          ),
                        ),
                        InputIcon(
                          placeholder: "50 reais",
                          controller: widget.real50Controller,
                          context: context,
                          isNumber: true,
                          icon: "images/coins/50_reais.jpg",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      children: [
                        InputIcon(
                          placeholder: "100 reais",
                          controller: widget.real100Controller,
                          context: context,
                          isNumber: true,
                          icon: "images/coins/100_reais.jpg",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 16),
                          child: InputIcon(
                            placeholder: "200 reais",
                            controller: widget.real200Controller,
                            context: context,
                            isNumber: true,
                            icon: "images/coins/200_reais.jpg",
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              resetInputs();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _theme.borderColor,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      _theme.borderRadius)),
                            ),
                            child: Text(
                              "Apagar campos",
                              style: TextStyle(
                                color: _theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                sumTotal(context: context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _theme.primaryColor,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        _theme.borderRadius)),
                              ),
                              child: const Text("Calcular"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetInputs() {
    widget.cents5Controller.clear();
    widget.cents10Controller.clear();
    widget.cents25Controller.clear();
    widget.cents50Controller.clear();
    widget.real1Controller.clear();
    widget.real2Controller.clear();
    widget.real5Controller.clear();
    widget.real10Controller.clear();
    widget.real20Controller.clear();
    widget.real50Controller.clear();
    widget.real100Controller.clear();
    widget.real200Controller.clear();
  }

  void sumTotal({required BuildContext context}) {
    double cents5 = widget.cents5Controller.text.isEmpty
        ? 0
        : int.parse(widget.cents5Controller.text) * 0.05;

    double cents10 = widget.cents10Controller.text.isEmpty
        ? 0
        : int.parse(widget.cents10Controller.text) * 0.1;

    double cents25 = widget.cents25Controller.text.isEmpty
        ? 0
        : int.parse(widget.cents25Controller.text) * 0.25;

    double cents50 = widget.cents50Controller.text.isEmpty
        ? 0
        : int.parse(widget.cents50Controller.text) * 0.5;

    int real1 = widget.real1Controller.text.isEmpty
        ? 0
        : int.parse(widget.real1Controller.text);

    int real2 = widget.real2Controller.text.isEmpty
        ? 0
        : int.parse(widget.real2Controller.text) * 2;

    int real5 = widget.real5Controller.text.isEmpty
        ? 0
        : int.parse(widget.real5Controller.text) * 5;

    int real10 = widget.real10Controller.text.isEmpty
        ? 0
        : int.parse(widget.real10Controller.text) * 10;

    int real20 = widget.real20Controller.text.isEmpty
        ? 0
        : int.parse(widget.real20Controller.text) * 20;

    int real50 = widget.real50Controller.text.isEmpty
        ? 0
        : int.parse(widget.real50Controller.text) * 50;

    int real100 = widget.real100Controller.text.isEmpty
        ? 0
        : int.parse(widget.real100Controller.text) * 100;

    int real200 = widget.real200Controller.text.isEmpty
        ? 0
        : int.parse(widget.real200Controller.text) * 200;

    double total = cents5 +
        cents10 +
        cents25 +
        cents50 +
        real1 +
        real2 +
        real5 +
        real10 +
        real20 +
        real50 +
        real100 +
        real200;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
                children: [
                  TextSpan(
                    text: "Você tem:\n",
                    children: [
                      TextSpan(
                        text: Formatters().formatMoneyBRL(value: total),
                        style: TextStyle(
                          color: _theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok")),
        ],
      ),
    );
  }
}
