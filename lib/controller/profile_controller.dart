import 'dart:convert';
import 'package:flashare/models/user.dart';
import 'package:flashare/utils/user_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String domain = dotenv.get('DOMAIN');

class ProfileController {
  Future<User> getProfile() async {
    try {
      String id = await SecureStorage.readSecureData(SecureStorage.userID);
      http.Response response = await http.get(
        Uri.parse("$domain/api/user/profile/get/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var body = jsonDecode(response.body);
      // return [body["success"], body["data"]];
      return User(
        ID: body["data"]["id"],
        Email: body["data"]["email"],
        Name: body["data"]["full_name"],
        avatarLink: body["data"]["avatar_link"],
        phoneNumber: body["data"]["phone_number"],
        address: body["data"]["address"],
        Password: body["data"]["password_hash_code"],
      );
    } catch (_) {
      throw Exception('-----ERROR get profile---------');
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
    required String id, // TODO:
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
