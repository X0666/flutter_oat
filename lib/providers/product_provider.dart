import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shamo/models/category_model.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/models/product_payment_model.dart';
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
      print("service getProduct ${resp}");
      _products = resp;
      return resp;
    } catch (e) {
      print('err: $e');
      return null;
    }
  }

  List<PoductPayments> _productsTransactions = [];

  List<PoductPayments> get productsTransactions => _productsTransactions;

  set productsTransactions(List<PoductPayments> data) {
    _productsTransactions = data;
    notifyListeners();
  }

  Future<List<PoductPayments>?> getProductsPayments(String token) async {
    try {
      var resp = await ProductService().getProductsPayment(token);
      print("service getProductsPayment ${resp}");
      _productsTransactions = resp;
      return resp;
    } catch (e) {
      print('err: $e');
      return null;
    }
  }

  Future<dynamic> deleteProducts(String token, String id) async {
    try {
      await ProductService().deleteProduct(token, id);
      return true;
    } catch (e) {
      print('err: $e');
      return null;
    }
  }

  //Categories
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  set categories(List<CategoryModel> data) {
    _categories = data;
    notifyListeners();
  }

  Future<List<CategoryModel>?> getCategories() async {
    try {
      var resp = await ProductService().getCategory();
      _categories = resp;
      return resp;
    } catch (e) {
      print('err: $e');
      return null;
    }
  }
}
