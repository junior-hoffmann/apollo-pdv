import 'package:apollo_pdv/models/product_sold.dart';
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

  List<ProductSold> getSaledProducts() {
    List<ProductSold> allProductsSold = [];
    List<ProductSold> products = [];

    for (Sale sale in _sales) {
      allProductsSold.addAll(sale.getSale()["products"]);
    }

    for (ProductSold product in allProductsSold) {
      bool found = false;

      for (int i = 0; i < products.length; i++) {
        if (products[i].getBarCode() == product.getBarCode()) {
          products[i].updateAmount(
              newAmount: products[i].getAmount() + product.getAmount());
          found = true;
          break;
        }
      }

      if (!found) {
        products.add(ProductSold(
          code: product.getCode(),
          barCode: product.getBarCode(),
          description: product.getDescription(),
          costPrice: product.getCostPrice(),
          salePrice: product.getSalePrice(),
          amount: product.getAmount(),
        ));
      }
    }

    return products;
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
