import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sponsorify/data/model/user_model.dart';

class RemoteUser {
  Future getData(token) async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/user"),
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

  // Future editData(token, name, email, profilePhoto) async {
  //   var headers = {'Authorization': 'Bearer $token'};
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('http://10.0.2.2:8080/api/user'));
  //   request.fields
  //       .addAll({'name': '$name', 'email': '$email', '_method': 'patch'});
  //   request.files.add(
  //       await http.MultipartFile.fromPath('profile_photo', '$profilePhoto'));
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //     return true;
  //   } else {
  //     print(response.reasonPhrase);
  //     return false;
  //   }
  // }

  Future editData(token, name, email, [profilePhoto]) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:8080/api/user'));
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
