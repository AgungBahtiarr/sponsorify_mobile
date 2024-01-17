import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:sponsorify/data/model/event_model.dart';

class RemoteEvent {
  Future getData(token) async {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}event"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => EventModel.fromJson(json)).toList();
    } else {
      throw (response.statusCode);
    }
  }

  Future getDetail(token, id) async {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}event/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return EventModel.fromJson(body);
    } else {
      throw (response.statusCode);
    }
  }

  Future addData(token, name, email, description, image) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${dotenv.env['API_URL']}event'));
    request.fields.addAll({'name': name, 'description': name, 'email': email});
    request.files.add(
        await http.MultipartFile.fromPath('profile_photo', image.toString()));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future deleteData(token, id) async {
    final response = await http.delete(
      Uri.parse("${dotenv.env['API_URL']}event/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
