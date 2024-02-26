import 'dart:convert';

class Company {
  late String _name;
  late Map<String, dynamic> _address;
  late String _cnpj;
  late String _phone;

  Company({
    required String name,
    required Map<String, dynamic> address,
    required String cnpj,
    required String phone,
  }) {
    _name = name;
    _address = address;
    _cnpj = cnpj;
    _phone = phone;
  }

  String getName() => _name;
  Map<String, dynamic> getAddress() => _address;
  String getCNPJ() => _cnpj;
  String getPhone() => _phone;

  String getJSON() {
    return json.encode({
      "name": _name,
      "address": {
        "street": _address["street"],
        "number": _address["number"],
        "neighborhood": _address["neighborhood"],
        "city": _address["city"],
        "uf": _address["uf"]
      },
      "cnpj": _cnpj,
      "phone": _phone
    });
  }
}
