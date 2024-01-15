import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sponsorify/data/model/user_model.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";

class RemoteUser {
  Future getData(token) async {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}user/current"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return UserModel.fromJson(json);
    } else {
      throw ("Error");
    }
  }

  Future editData(token, name, email, [profilePhoto]) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${dotenv.env['API_URL']}user/current'));
    request.fields
        .addAll({'name': '$name', 'email': '$email', '_method': 'patch'});
    if (profilePhoto != null) {
      request.files.add(
          await http.MultipartFile.fromPath('profile_photo', '$profilePhoto'));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
