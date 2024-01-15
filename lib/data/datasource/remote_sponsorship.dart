import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:sponsorify/data/model/sponsorship_model.dart';

class RemoteSponsorship {
  Future getData(token) async {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}sponsorship"),
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
            (value) => SponsorshipModel.fromJson(value),
          )
          .toList();
    } else {
      debugPrint(response.body);
    }
  }

  Future getDataWithCategory(token, id) async {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}sponsorship/category/$id"),
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
            (value) => SponsorshipModel.fromJson(value),
          )
          .toList();
    } else {
      debugPrint(response.body);
    }
  }

  Future getDetail(token, id) async {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}sponsorship/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return SponsorshipModel.fromJson(body);
    } else {
      throw ('Error bos');
    }
  }

  Future getAuthDetail(token) async {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}sponsorship/detail"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return SponsorshipModel.fromJson(body);
    } else {
      throw ('Error bos');
    }
  }

  Future addData(token, name, email, description, address, idCategory,
      [image]) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${dotenv.env['API_URL']}sponsorship'));
    request.fields.addAll({
      'name': '$name',
      'email': '$email',
      'description': '$description',
      'address': '$address',
      'id_category': '$idCategory'
    });

    try {
      request.files
          .add(await http.MultipartFile.fromPath('profile_photo', '$image'));
    } catch (e) {
      return false;
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> count(id) async {
    final response = await http
        .get(Uri.parse('${dotenv.env['API_URL']}sponsorship/count/$id'));

    var body = jsonDecode(response.body);
    return body['count'];
  }

  Future<bool> editData(
      token, idSponsorship, name, email, description, address, idCategory,
      [profilPhoto]) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST',
        Uri.parse('${dotenv.env['API_URL']}sponsorship/$idSponsorship'));
    request.fields.addAll({
      '_method': 'patch',
      'name': '$name',
      'email': '$email',
      'description': '$description',
      'address': '$address',
      'id_category': '$idCategory'
    });

    if (profilPhoto != null) {
      request.files.add(
          await http.MultipartFile.fromPath('profile_photo', '$profilPhoto'));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future search(token, search) async {
    List<SponsorshipModel> sponsorships = [];
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST', Uri.parse('${dotenv.env['API_URL']}sponsorship/search'));
    request.bodyFields = {'search': search};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(await response.stream.bytesToString());
      return body.map((value) => SponsorshipModel.fromJson(value)).toList();
    } else {
      return sponsorships;
    }
  }
}
