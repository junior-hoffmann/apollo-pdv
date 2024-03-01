// ignore_for_file: deprecated_member_use

import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VendaFinalizadaScreen extends StatelessWidget {
  VendaFinalizadaScreen({super.key});

  final AppTheme _theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Image.asset("images/logo/logo_apollo_pdv.png"),
                  ),
                ),
                Text(
                  "Venda realizada com sucesso!",
                  style: TextStyle(
                    color: _theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Text(
                    "O que você quer fazer agora?",
                    style: TextStyle(
                      color: _theme.secondaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                       Navigator.pop(context, {
                          "action": "new"
                        },);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _theme.primaryColor,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      shape: ContinuousRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(_theme.borderRadius)),
                    ),
                    child: const Text("Nova venda"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          {"action": "home"},
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 221, 230, 217),
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: ContinuousRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(_theme.borderRadius)),
                      ),
                      child: Text(
                        "Sair para o menu",
                        style: TextStyle(color: _theme.primaryColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          child: SvgPicture.asset(
            "images/rodape.svg",
            fit: BoxFit.cover,
            // height: MediaQuery.of(context).size.height * 0.2,
            alignment: Alignment.topCenter,
            color: _theme.primaryColor,
          ),
        ));
  }
}
