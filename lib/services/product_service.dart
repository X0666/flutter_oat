import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:shamo/models/category_model.dart';
import 'package:shamo/models/product_model.dart';

class ProductService {
  String baseUrl = 'https://farid1.online/api';

  Future<List<ProductModel>> getProducts() async {
    var url = Uri.parse('$baseUrl/products');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    print('getProducts $response');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];
      print('getProducts ${data.length}');
      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }

  Future<List<CategoryModel>> getCategory() async {
    var url = Uri.parse('$baseUrl/categories');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    print("getCategories $response");

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<CategoryModel> categories = [];

      for (var item in data) {
        categories.add(CategoryModel.fromJson(item));
      }

      return categories;
    } else {
      throw Exception('Gagal Get categories!');
    }
  }

  Future<dynamic> createProduct(
    String token,
    String name,
    String desc,
    String price,
    int categories,
    String tags,
    List<File> image,
  ) async {
    var url = Uri.parse('$baseUrl/admin/products');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var request = await http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    request.fields.addAll({
      'name': name,
      'description': desc,
      'price': price,
      'categories_id': '$categories',
      'tags': tags
    });

    for (var filePath in image) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'gallery[]',
          filePath.path,
          filename: filePath.path.split('/').last,
        ),
      );
    }

    try {
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Upload failed with status ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error uploading: $error');
      return false;
    }
  }

  Future<dynamic> updateProduct(
    String token,
    String id,
    String name,
    String desc,
    String price,
    int categories,
    String tags,
    List<File> image,
  ) async {
    var url = Uri.parse('$baseUrl/admin/products/$id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var request = await http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    request.fields.addAll({
      'name': name,
      'description': desc,
      'price': price,
      'categories_id': '$categories',
      'tags': tags
    });

    for (var filePath in image) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'gallery[]',
          filePath.path,
          filename: filePath.path.split('/').last,
        ),
      );
    }

    try {
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Upload failed with status ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error uploading: $error');
      return false;
    }
  }

  Future<dynamic> deleteProduct(
    String token,
    String id,
  ) async {
    var url = Uri.parse('$baseUrl/admin/products/$id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var response = await http.delete(url, headers: headers);

    print('deleteProduct $response');

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Delete Products!');
    }
  }
}
