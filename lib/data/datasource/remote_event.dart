import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sponsorify/data/model/event_model.dart';

class RemoteEvent {
  Future getData(token) async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/event"),
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

  Future addData(token, name, email, description, image) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:8080/api/event'));
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
      Uri.parse("http://10.0.2.2:8080/api/event/$id"),
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
