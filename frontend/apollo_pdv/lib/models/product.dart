class Product {
  late String _id;
  late String _code;
  late String _barCode;
  late String _description;
  late double _costPrice;
  late double _salePrice;
  late int _stock;

  Product(
      {required String code,
      required String barCode,
      required String description,
      required double costPrice,
      required double salePrice,
      required int stock}) {
    _code = code;
    _barCode = barCode;
    _description = description;
    _costPrice = costPrice;
    _salePrice = salePrice;
    _stock = stock;
  }

  String getId() => _id;
  String getCode() => _code;
  String getBarCode() => _barCode;
  String getDescription() => _description;
  double getCostPrice() => _costPrice;
  double getSalePrice() => _salePrice;
  int getStock() => _stock;

  void setId({required String id}) => _id = id;
  void setCode({required String code}) => _code = code;
  void setBarCode({required String barCode}) => _barCode = barCode;
  void setDescription({required String description}) =>
      _description = description;
  void setCostPrice({required double costPrice}) => _costPrice = costPrice;
  void setSalePrice({required double salePrice}) => _salePrice = salePrice;
  void setStock({required int amount}) => _stock;

  void updateStock({required int amount}) =>
      _stock > 0 && _stock > amount ? _stock -= amount : _stock = 0;
}
