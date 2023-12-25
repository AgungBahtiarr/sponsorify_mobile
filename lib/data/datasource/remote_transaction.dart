import 'package:http/http.dart' as http;

class RemoteTransaction {
  Future addTransaction(
      token, idEvent, idSponsorship, idProposal, sponsorshipFunds) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.Request('POST', Uri.parse('http://10.0.2.2:8080/api/transaction'));
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
