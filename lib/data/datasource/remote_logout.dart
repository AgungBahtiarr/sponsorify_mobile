import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RemoteLogout {
  Future logout(token) async {
    final response = await http.delete(
      Uri.parse('${dotenv.env['API_URL']}logout'),
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
