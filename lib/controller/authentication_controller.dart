import 'dart:convert';
import 'package:flashare/utils/user_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthenticationController {
  Future<List> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    String id = await SecureStorage.readSecureData(SecureStorage.userID);
    var json = jsonEncode({
      "id": id,
      "old_password": oldPassword,
      "new_password": newPassword,
    });
    print(json);

    try {
      String domain = dotenv.get('DOMAIN');
      http.Response response = await http.post(
          Uri.parse("http://$domain/api/user/profile/change-password"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json);
      var body = jsonDecode(response.body);
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }
}
