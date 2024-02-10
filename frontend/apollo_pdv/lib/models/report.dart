import 'package:apollo_pdv/models/sale.dart';

class Report {
  late List<Sale> _sales;

  Report({required List<Sale> sales}) {
    _sales = sales;
  }

  List<Sale> getSales() => [..._sales];

  double getTotal() {
    double total = 0;

    for (Sale sale in _sales) {
      total += sale.getSale()["total"]["total"];
    }

    return total;
  }

  double getProfit() {
    double total = 0;

    for (Sale sale in _sales) {
      total += sale.getSale()["profit"];
    }

    return total;
  }

  Map<String, double> getPayments() {
    double money = 0;
    double creditCard = 0;
    double debitCard = 0;
    double pix = 0;
    double check = 0;

    for (Sale sale in _sales) {
      money += sale.getSale()["paymentForm"]["money"];
      creditCard += sale.getSale()["paymentForm"]["creditCard"];
      debitCard += sale.getSale()["paymentForm"]["debitCard"];
      pix += sale.getSale()["paymentForm"]["pix"];
      check += sale.getSale()["paymentForm"]["check"];
    }

    return {
      "money": money,
      "creditCard": creditCard,
      "debitCard": debitCard,
      "pix": pix,
      "check": check,
    };
  }

  double getAverageTicket() => getTotal() / _sales.length;
}
