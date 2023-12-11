import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shamo/models/cart_model.dart';
import 'package:shamo/models/category_model.dart';
import 'package:shamo/models/transaction_model.dart';

class TransactionService {
  String baseUrl = 'https://farid1.online/api';

  Future<TransactionModel> chceckout(
      String token, List<CartModel> carts, double totalPrice) async {
    var url = Uri.parse('$baseUrl/checkout');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode(
      {
        'address': 'Dinosaur',
        'items': carts
            .map(
              (cart) => {
                'id': cart.product?.id,
                'quantity': cart.quantity,
              },
            )
            .toList(),
        'status': "PENDING",
        'total_price': totalPrice,
        'shipping_price': 0,
      },
    );
    var response = await http.post(
      url as Uri,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      var datas = TransactionModel.fromJson(data);

      return datas;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }

  Future<bool> setTransactionPaid(
      String token, int transactionId, int paymentId) async {
    var url = Uri.parse('$baseUrl/transaction/paid');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode(
      {
        "id": transactionId,
        "payment_id": paymentId,
      },
    );
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print('transaction pay method ${response.body}');

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Pembayaran Gagal!');
    }
  }

  Future<List<CategoryModel>> getPaymentMethods() async {
    var url = Uri.parse('$baseUrl/payment-method');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    print('getProducts $response');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<CategoryModel> products = [];
      print('getProducts ${data.length}');
      for (var item in data) {
        products.add(CategoryModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }
}
