// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:apollo_pdv/models/company.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CompanyProvider extends ChangeNotifier {
  final String server = "http://localhost:9090";

  Company _company = Company(name: "", address: {}, cnpj: "", phone: "");

  Future<bool> setCompany({required Company company}) async {
    String url = "$server/admin/empresa/editar";
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: company.getJSON(),
      );
      if (response.statusCode == 200) {
        getCompany();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> getCompany() async {
    String url = "$server/admin/empresa/buscar";
    try {
      var response = await http.get(Uri.parse(url));
      var data = json.decode(response.body);

      Company company = Company(
        name: data["name"].toString(),
        address: {
          "street": data["address"]["street"].toString(),
          "number": data["address"]["number"].toString(),
          "neighborhood": data["address"]["neighborhood"].toString(),
          "city": data["address"]["city"].toString(),
          "uf": data["address"]["uf"].toString(),
        },
        cnpj: data["cnpj"].toString(),
        phone: data["phone"].toString(),
      );
      _company = company;
    } catch (e) {
      print("Houve um erro: $e");
    }
    notifyListeners();
  }

  Company company() => _company;
}
