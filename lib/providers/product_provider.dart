import 'package:flutter/material.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<List<ProductModel>?> getProducts() async {
    try {
      var resp = await ProductService().getProducts();
      _products = resp;
      return resp;
    } catch (e) {
      print('err: $e');
      return null;
    }
  }
}