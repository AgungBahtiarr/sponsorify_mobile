import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:sponsorify/data/model/proposal_model.dart';
import 'package:sponsorify/data/model/proposal_sponsorship_model.dart';

class RemoteProposal {
  Future getData(token) async {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}proposal"),
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
            (value) => ProposalModel.fromJson(value),
          )
          .toList();
    } else {
      throw ('error bos');
    }
  }

  Future getProposalSponsorship(token) async {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}proposal/sponsorship"),
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
            (value) => ProposalSponsorshipModel.fromJson(value),
          )
          .toList();
    } else {
      throw ('error bos');
    }
  }

  Future addProposal(proposal, token, idSponsorship, idEvent, idUser) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${dotenv.env['API_URL']}proposal'));
    request.fields.addAll({
      'id_sponsorship': '$idSponsorship',
      'id_event': '$idEvent',
      'id_status': '1'
    });
    request.files
        .add(await http.MultipartFile.fromPath('proposal', '$proposal'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future countProposal(token) async {
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}proposal/sponsorship/count'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return body;
    } else {
      return 'failed getting data';
    }
  }

  Future updateProposal(token, id, message, idStatus) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST', Uri.parse('${dotenv.env['API_URL']}proposal/sponsorship/$id'));
    request.bodyFields = {
      '_method': 'patch',
      'message': '$message',
      'id_status': '$idStatus'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      return true;
    } else {
      // print(response.reasonPhrase);
      // print(response.statusCode);
      return false;
    }
  }
}
