class ProductSold {
  late String _code;
  late String _barCode;
  late String _description;
  late double _costPrice;
  late double _salePrice;
  late int _amount;

  ProductSold(
      {required String code,
      required String barCode,
      required String description,
      required double costPrice,
      required double salePrice,
      required int amount}) {
    _code = code;
    _barCode = barCode;
    _description = description;
    _costPrice = costPrice;
    _salePrice = salePrice;
    _amount = amount;
  }

  String getCode() => _code;
  String getBarCode() => _barCode;
  String getDescription() => _description;
  double getCostPrice() => _costPrice;
  double getSalePrice() => _salePrice;
  int getAmount() => _amount;
  double getTotal() => _amount * _salePrice;

  void updateAmount({required int newAmount}) => _amount = newAmount;


}
