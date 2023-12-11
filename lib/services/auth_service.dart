import 'dart:convert';

import 'package:shamo/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'https://farid1.online/api';

  Future<userModel> register({
    String? name,
    String? username,
    String? email,
    String? password,
  }) async {
    var url = Uri.parse('$baseUrl/register');
    print('$url');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });
    print(body);
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    // print(response.body);
    print('response = $response');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      userModel user = userModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<userModel> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse('$baseUrl/login');

    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      userModel user = userModel.fromJson(data['User']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Loginnn');
    }
  }
}
