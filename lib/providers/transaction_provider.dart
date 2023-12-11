import 'package:flutter/material.dart';
import 'package:shamo/models/cart_model.dart';
import 'package:shamo/models/transaction_model.dart';
import 'package:shamo/services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  Future<TransactionModel> checkout(
      String token, List<CartModel> carts, double totalPrice) async {
    try {
      var resp = await TransactionService().chceckout(token, carts, totalPrice);
      if (resp.id != null) {
        return resp;
      } else {
        return TransactionModel();
      }
    } catch (e) {
      print(e);
      return TransactionModel();
    }
  }

  Future<bool> setPaid(String token, int transactionId, int paymentId) async {
    try {
      if (await TransactionService()
          .setTransactionPaid(token, transactionId, paymentId)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
