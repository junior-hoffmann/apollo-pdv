// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:apollo_pdv/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsProvider extends ChangeNotifier {
  final String server = "http://localhost:9090";

  final List<Product> _products = [];

  List<Product> get products => [..._products];

  Future<void> getProducts() async {
    _products.clear();
    String url = "$server/produtos/todos-os-produtos/";
    try {
      var response = await http.get(Uri.parse(url));
      var data = json.decode(response.body);
      for (var item in data) {
        Product product = Product(
          description: (item["description"]).toString(),
          barCode: (item["barCode"]).toString(),
          code: (item["code"]).toString(),
          stock: int.parse(item["stock"].toString()),
          costPrice: double.parse(item["costPrice"].toString()),
          salePrice: double.parse(item["salePrice"].toString()),
        );

        product.setId(id: item["_id"].toString());
        _products.add(product);
      }
    } catch (e) {
      print("Houve um erro: $e");
    }
    notifyListeners();
  }

  Future<String> setProduct({required Product product}) async {
    String url = "$server/admin/produtos/novo-produto";
    try {
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "code": product.getCode(),
            "barCode": product.getBarCode(),
            "description": product.getDescription(),
            "costPrice": product.getCostPrice(),
            "salePrice": product.getSalePrice(),
            "stock": product.getStock(),
          }));
      if (response.statusCode == 200) {
        await getProducts();
        notifyListeners();
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateProduct(
      {required Product product, required String id}) async {
    String url = "$server/admin/produtos/editar/$id";
    try {
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "code": product.getCode(),
            "barCode": product.getBarCode(),
            "description": product.getDescription(),
            "costPrice": product.getCostPrice(),
            "salePrice": product.getSalePrice(),
            "stock": product.getStock(),
          }));
      if (response.statusCode == 200) {
        await getProducts();
        notifyListeners();
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> setStock({required String barCode, required int amount}) async {
    String url = "$server/admin/produtos/set-estoque/";
    try {
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "barCode": barCode,
            "amount": amount,
          }));
      if (response.statusCode == 200) {
        await getProducts();
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deleteProduct({required String id}) async {
    String url = "$server/admin/produtos/excluir-produto/$id";
    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        await getProducts();
        notifyListeners();
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
