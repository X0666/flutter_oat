import 'package:flutter/material.dart';
import 'package:shamo/models/cart_model.dart';
import 'package:shamo/models/category_model.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/services/transaction_service.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];

  List<CartModel> get carts => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  addCart(ProductModel product) {
    if (productExist(product)) {
      int index =
          _carts.indexWhere((element) => element.product?.id == product.id);
      var quantity = _carts[index].quantity ?? 0;
      quantity++;
    } else {
      _carts.add(
        CartModel(
          id: _carts.length,
          product: product,
          quantity: 1,
        ),
      );
    }

    notifyListeners();
  }

  removeCart(int id) {
    _carts.removeAt(id);
    notifyListeners();
  }

  addQuantity(int id) {
    var quantity = _carts[id].quantity ?? 0;
    quantity++;
    notifyListeners();
  }

  reduceQuantity(int id) {
    var quantity = _carts[id].quantity ?? 0;
    quantity--;
    if (_carts[id].quantity == 0) {
      _carts.removeAt(id);
    }
    notifyListeners();
  }

  totalItems() {
    int total = 0;
    for (var item in _carts) {
      total += item.quantity!;
    }
    return total;
  }

  totalPrice() {
    double total = 0;
    for (var item in _carts) {
      total += (item.quantity! * item.product!.price!);
    }
    return total;
  }

  productExist(ProductModel product) {
    if (_carts.indexWhere((element) => element.product?.id == product.id) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }

  List<CategoryModel> _paymentMethods = [];

  List<CategoryModel> get paymentMethods => _paymentMethods;

  set products(List<CategoryModel> datas) {
    _paymentMethods = datas;
    notifyListeners();
  }

  Future<List<CategoryModel>?> getPaymentMethods() async {
    try {
      var resp = await TransactionService().getPaymentMethods();
      print("service getPaymentMethods ${resp}");
      _paymentMethods = resp;
      return resp;
    } catch (e) {
      print('err: $e');
      return null;
    }
  }
}
