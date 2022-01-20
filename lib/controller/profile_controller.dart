import 'dart:convert';
import 'package:flashare/utils/user_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String domain = dotenv.get('DOMAIN');

class ProfileController {
  Future<dynamic> getProfile() async {
    try {
      String id = await SecureStorage.readSecureData(SecureStorage.userID);
      http.Response response = await http.get(
          Uri.parse("$domain/api/user/profile/get/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          );
      var body = jsonDecode(response.body);
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }

  Future<dynamic> getReview({
    required String id,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(""), // TODO: API GET REVIEW
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var body = jsonDecode(response.body);
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }

  Future<dynamic> updateProfile({
    required String id,  // TODO: 
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(""), // TODO: API update profile
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var body = jsonDecode(response.body);
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }
}
