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
}