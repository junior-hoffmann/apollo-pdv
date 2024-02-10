import 'package:currency_formatter/currency_formatter.dart';

class Formatters {
  final CurrencyFormatterSettings _brl = CurrencyFormatterSettings(
    symbol: "R\$",
    symbolSide: SymbolSide.left,
    thousandSeparator: ".",
    decimalSeparator: ",",
  );

  final CurrencyFormatterSettings _brlNoSimbol = CurrencyFormatterSettings(
    symbol: "",
    symbolSide: SymbolSide.left,
    thousandSeparator: ".",
    decimalSeparator: ",",
  );

  String formatMoneyBRL({required double value}) {
    if (value % 1 == 0) {
      return "${CurrencyFormatter().format(value, _brl)},00";
    } else {
      return CurrencyFormatter().format(value, _brl);
    }
  }

  String formatMoneyBRLNoSimbol({required double value}) {
    if (value % 1 == 0) {
      return "${CurrencyFormatter().format(value, _brlNoSimbol)},00";
    } else {
      return CurrencyFormatter().format(value, _brlNoSimbol);
    }
  }

  String formatSimpleDate({required DateTime date}) =>
      "${date.day}/${date.month}/${date.year}";

  String formatDate({required DateTime date}) =>
      "${date.day}/${date.month}/${date.year} - ${date.hour}h${date.minute}";

  String today() {
    String day = "";
    String month = "";

    if (DateTime.now().month < 10) {
      month = "0${DateTime.now().month}";
    } else {
      month = "${DateTime.now().month}";
    }

    if (DateTime.now().day < 10) {
      day = "0${DateTime.now().day}";
    } else {
      day = "${DateTime.now().day}";
    }
    return "${DateTime.now().year}-$month-$day";
  }
}
