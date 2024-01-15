import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:sponsorify/data/model/login_model.dart';

class RemoteLogin {
  Future login(LoginModel user) async {
    final response = await http.post(Uri.parse('${dotenv.env['API_URL']}login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(user));

    var data = jsonDecode(response.body);
    LoginModel? user1;

    if (response.statusCode == 200) {
      user1 = LoginModel.fromJson(data);
    } else {
      user1 = LoginModel.fromJsonFail(data);
    }

    if (user1.success == true) {
      return user1;
    } else {
      user1.success == false;
      return user1;
    }
  }
}
