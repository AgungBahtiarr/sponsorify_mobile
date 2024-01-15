import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:sponsorify/data/model/transaction_model.dart';

class RemoteTransaction {
  Future getTransaction(token) async {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}transaction"),
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
            (value) => Transaction.fromJson(value),
          )
          .toList();
    } else {
      throw ('error bos');
    }
  }

  Future getDetailTransaction(token, id) async {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}transaction/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return Transaction.fromJson(body);
    } else {
      throw ('error bos');
    }
  }

  Future addTransaction(
      token, idEvent, idSponsorship, idProposal, sponsorshipFunds) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.Request('POST', Uri.parse('${dotenv.env['API_URL']}transaction'));
    request.bodyFields = {
      'id_event': '$idEvent',
      'id_sponsorship': '$idSponsorship',
      'id_proposal': '$idProposal',
      'sponsorship_funds': '$sponsorshipFunds'
    };
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
