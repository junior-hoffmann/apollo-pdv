import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';

class PaymentCardReport extends StatelessWidget {
  PaymentCardReport(
      {super.key,
      required this.title,
      required this.value,
      required this.image,
      required this.size});
  final AppTheme _theme = AppTheme();
  final String title;
  final String value;
  final String image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: _theme.borderColor),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      width: size,
      height: size,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FractionallySizedBox(
              widthFactor: 0.3,
              child: Image.asset(image),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: size * 0.10,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: size * 0.12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
