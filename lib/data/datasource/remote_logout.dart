import 'package:http/http.dart' as http;

class RemoteLogout {
  Future logout(token) async {
    final response = await http.delete(
      Uri.parse('http://10.0.2.2:8080/api/logout'),
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
