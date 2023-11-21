import 'package:http/http.dart' as http;

class RemoteProposal {
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
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      print(response.statusCode);
      return false;
    }
  }
}
