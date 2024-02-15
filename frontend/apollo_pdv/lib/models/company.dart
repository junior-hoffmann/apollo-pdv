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
}
