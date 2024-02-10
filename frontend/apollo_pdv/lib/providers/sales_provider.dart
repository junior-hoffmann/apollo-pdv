// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:apollo_pdv/models/product_sold.dart';
import 'package:apollo_pdv/models/sale.dart';
import 'package:apollo_pdv/utils/formaters.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SalesProvider extends ChangeNotifier {
  final String server = "http://localhost:9090";

  final List<Sale> _sales = [];
  List<Sale> get sales => [..._sales];

  Future<bool> setNewSale({required Sale sale}) async {
    String url = "$server/admin/vendas/nova-venda";
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: sale.getJSON(),
      );
      if (response.statusCode == 200) {
        getSales();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      // return "Ocorreu o seguinte erro: $e";
      return false;
    }
  }

  Future<List<Sale>> getTodaySales() async {
    List<Sale> todaySales = [];

    String today = Formatters().today();

    String url = "$server/admin/vendas/vendas-filtradas/$today";

    try {
      var response = await http.get(Uri.parse(url));
      var data = json.decode(response.body);
      for (var item in data) {
        Sale sale = Sale(
            date: DateTime.parse(item["date"]),
            products: [],
            discount: double.parse(item["discount"].toString()),
            paymentForm: {
              "money": double.parse(item["paymentForm"]["money"].toString()),
              "creditCard":
                  double.parse(item["paymentForm"]["creditCard"].toString()),
              "debitCard":
                  double.parse(item["paymentForm"]["debitCard"].toString()),
              "pix": double.parse(item["paymentForm"]["pix"].toString()),
              "check": double.parse(item["paymentForm"]["check"].toString()),
            });

        sale.setSerialCode(serialCode: item["serialCode"].toString());

        var products = item["products"];
        for (var product in products) {
          sale.setProduct(
            product: ProductSold(
                code: product["code"].toString(),
                barCode: product["barCode"].toString(),
                description: product["description"].toString(),
                costPrice: double.parse(product["costPrice"].toString()),
                salePrice: double.parse(product["salePrice"].toString()),
                amount: int.parse(product["amount"].toString())),
          );
        }
        todaySales.add(sale);
      }
      return todaySales;
    } catch (e) {
      print("Houve um erro no Sales Provider: $e");
      return [];
    }
  }

  Future<void> getSales() async {
    _sales.clear();
    String url = "$server/admin/vendas/todas-as-vendas/";
    try {
      var response = await http.get(Uri.parse(url));
      var data = json.decode(response.body);
      for (var item in data) {
        Sale sale = Sale(
            date: DateTime.parse(item["date"]),
            products: [],
            discount: double.parse(item["discount"].toString()),
            paymentForm: {
              "money": double.parse(item["paymentForm"]["money"].toString()),
              "creditCard":
                  double.parse(item["paymentForm"]["creditCard"].toString()),
              "debitCard":
                  double.parse(item["paymentForm"]["debitCard"].toString()),
              "pix": double.parse(item["paymentForm"]["pix"].toString()),
              "check": double.parse(item["paymentForm"]["check"].toString()),
            });

        sale.setSerialCode(serialCode: item["serialCode"].toString());

        var products = item["products"];
        for (var product in products) {
          sale.setProduct(
            product: ProductSold(
                code: product["code"].toString(),
                barCode: product["barCode"].toString(),
                description: product["description"].toString(),
                costPrice: double.parse(product["costPrice"].toString()),
                salePrice: double.parse(product["salePrice"].toString()),
                amount: int.parse(product["amount"].toString())),
          );
        }
        _sales.add(sale);
      }
      notifyListeners();
    } catch (e) {
      print("Houve um erro no Sales Provider: $e");
    }
  }
}
