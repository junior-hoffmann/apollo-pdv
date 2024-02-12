import 'dart:convert';

import 'package:apollo_pdv/models/product_sold.dart';
import 'package:apollo_pdv/utils/formaters.dart';

class Sale {
  late String _serialCode;
  late DateTime _date;
  late List<ProductSold> _products;
  late double _discount;
  late Map<String, double> _paymentForm;
  double _totalWithoutDiscount = 0;

  Sale(
      {required String dateIso,
      required List<ProductSold> products,
      required double discount,
      required Map<String, double> paymentForm}) {
    _date = DateTime.parse(dateIso);
    _products = products;
    _discount = discount;
    _paymentForm = paymentForm;
    _sumTotal();
  }

  DateTime getDate() => _date;

  Map<String, dynamic> getSale() => {
        "date": Formatters().formatDate(date: _date),
        "products": [..._products],
        "paymentForm": {..._paymentForm},
        "discount": _discount,
        "profit": _getProfit(),
        "total": {
          "totalWithoutDiscount": _totalWithoutDiscount,
          "total": _totalWithoutDiscount - _discount
        }
      };

  double _getProfit(){
    double cost = 0;
    for(ProductSold product in _products){
      cost += product.getCostPrice() * product.getAmount();
    }
    return _totalWithoutDiscount - _discount - cost;
  }

  String getJSON() {
    List products = [];

    for (ProductSold product in _products) {
      products.add({
        "description": product.getDescription(),
        "costPrice": product.getCostPrice(),
        "barCode": product.getBarCode(),
        "salePrice": product.getSalePrice(),
        "code": product.getCode(),
        "amount": product.getAmount()
      });
    }

    return json.encode({
      "discount": _discount,
      "paymentForm": _paymentForm,
      "serialCode": DateTime.now().millisecondsSinceEpoch,
      "date": DateTime.now().toIso8601String(),
      "products": products,
    });
  }

  void _sumTotal() {
    _totalWithoutDiscount = 0;
    for (ProductSold product in _products) {
      _totalWithoutDiscount += product.getAmount() * product.getSalePrice();
    }
  }

  void setProduct({required ProductSold product}) {
    _products.add(product);
    _sumTotal();
  }

  void setSerialCode({required String serialCode}) => _serialCode = serialCode;

  String getSerialCode() => _serialCode;
}
