import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sponsorify/data/model/saved_model.dart';

class RemoteSaved {
  Future getData(token) async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/saved"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body
          .map(
            (value) => SavedModel.fromJson(value),
          )
          .toList();
    } else {
      // debugPrint(response.body);
      throw ('error bos');
    }
  }

  Future deleteData(token, id) async {
    final response = await http.delete(
      Uri.parse("http://10.0.2.2:8080/api/saved/$id"),
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

  Future addData(token, id) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:8080/api/saved'));
    request.fields.addAll({'id_sponsorship': '$id'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}
