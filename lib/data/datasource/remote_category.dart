import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:sponsorify/data/model/category_model.dart';

class RemoteCategory {
  Future getCategory() async {
    final response =
        await http.get(Uri.parse("${dotenv.env['API_URL']}category"));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((value) => CategoryModel.fromJson(value)).toList();
    }
  }
}
