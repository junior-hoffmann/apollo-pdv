// ignore_for_file: must_be_immutable

import 'package:apollo_pdv/screens/widgets/input.dart';
import 'package:apollo_pdv/screens/widgets/snackbar.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';

class DiscountButton extends StatelessWidget {
  DiscountButton({
    super.key,
    required this.mainContext,
    required this.onClick,
  });
  BuildContext mainContext;
  Function onClick;
  final AppTheme _theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        TextEditingController controller = TextEditingController();
        showDialog(
          context: mainContext,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(mainContext).size.width / 3,
                  child: Input(
                    placeholder: "Qual o percentual de desconto?",
                    controller: controller,
                    context: mainContext,
                    isNumber: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(mainContext, true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _theme.primaryColor,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: ContinuousRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(_theme.borderRadius)),
                      ),
                      child: const Text("Aplicar desconto"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ).then((value) {
          onClick(
            discount: double.parse(controller.text),
            context: mainContext,
          );
          if (value) {
            ScaffoldMessenger.of(mainContext).showSnackBar(Warnings().snackBar(
                value: "Desconto aplicado",
                backgroundColor: _theme.primaryColor,
                textColor: Colors.white));
          }
        });
      },
      icon: const Icon(Icons.percent),
    );
  }
}
