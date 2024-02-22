import 'package:apollo_pdv/models/product_sold.dart';

class UtilsReport {
  String sumItens({required List<ProductSold> products}) {
    int itensAmount = 0;
    for (ProductSold product in products) {
      itensAmount += product.getAmount();
    }
    return itensAmount.toString();
  }

  

  String paymentForm({required Map<String, dynamic> paymentForm}) {
    List<String> methods = [];

    if (paymentForm.containsKey("money") && paymentForm["money"] > 0) {
      methods.add("Dinheiro");
    }
    if (paymentForm.containsKey("creditCard") &&
        paymentForm["creditCard"] > 0) {
      methods.add("Cartão de Crédito");
    }
    if (paymentForm.containsKey("debitCard") && paymentForm["debitCard"] > 0) {
      methods.add("Cartão de Débito");
    }
    if (paymentForm.containsKey("pix") && paymentForm["pix"] > 0) {
      methods.add("Pix");
    }
    if (paymentForm.containsKey("check") && paymentForm["check"] > 0) {
      methods.add("Cheque");
    }

    if (methods.isEmpty) {
      return "Sem informações de pagamento";
    } else {
      return methods.join(' e ');
    }
  }
}
