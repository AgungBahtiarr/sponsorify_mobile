import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sponsorify/data/model/proposal_model.dart';
import 'package:sponsorify/data/model/proposal_sponsorship_model.dart';

class RemoteProposal {
  Future getData(token) async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/proposal"),
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
      Uri.parse("http://10.0.2.2:8080/api/proposal/sponsorship"),
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
        'POST', Uri.parse('http://10.0.2.2:8080/api/proposal'));
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
      Uri.parse('http://10.0.2.2:8080/api/proposal/sponsorship/count'),
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
}
