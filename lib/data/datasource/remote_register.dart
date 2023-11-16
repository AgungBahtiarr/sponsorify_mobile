import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/register_model.dart';

class RemoteRegister {
  Future<int> register(Data user) async {
    final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(user));
    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
