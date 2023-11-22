import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sponsorify/data/model/sponsorship_model.dart';

class RemoteSponsorship {
  Future getData(token) async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/sponsorship"),
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
            (value) => Sponsorship.fromJson(value),
          )
          .toList();
    } else {
      debugPrint(response.body);
    }
  }

  Future getDataWithCategory(token, id) async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/sponsorship/category/$id"),
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
            (value) => Sponsorship.fromJson(value),
          )
          .toList();
    } else {
      debugPrint(response.body);
    }
  }

  Future getDetail(token, id) async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/sponsorship/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return Sponsorship.fromJson(body);
    } else {
      throw ('Error bos');
    }
  }
}
