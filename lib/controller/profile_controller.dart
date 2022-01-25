import 'dart:convert';
import 'package:flashare/models/user.dart';
import 'package:flashare/utils/user_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String domain = dotenv.get('DOMAIN');

class ProfileController {
  Future<User> getProfile({String? userId}) async {
    try {
      String id = await SecureStorage.readSecureData(SecureStorage.userID);
      if (userId != null) id = userId;
      http.Response response = await http.get(
        Uri.parse("http://$domain/api/user/profile/get/$id"),
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

  Future<dynamic> updateProfile({
    required String newName,
    required String newPhone,
    required String newAdrr,
    String? avatar,
  }) async {
    String id = await SecureStorage.readSecureData(SecureStorage.userID);
    Map<String, dynamic> m = {};
    m["id"] = id;
    if (newName != "") m["full_name"] = newName;
    if (newPhone != "") m["phone_number"] = newPhone;
    if (newAdrr != "") m["address"] = newAdrr;
    var json = jsonEncode(m);
    Map<String, dynamic> mm = {};
    mm["id"] = id;
    if (avatar != "") m["avatar_base64"] = avatar;
    var json2 = jsonEncode(mm);
    print(json);
    try {
      http.Response response = await http.post(
        Uri.parse(
            "http://$domain/api/user/profile/update-info"), // TODO: API update profile
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json,
      );
      if (avatar != null) {
      http.Response res = await http.post(Uri.parse(
            "http://$domain/api/user/profile/update-info"), // TODO: API update profile
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json2,); 
      }
      var body = jsonDecode(response.body);
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }

  Future<dynamic> updateAvatar({
    required String avatar,
  }) async {
    String id = await SecureStorage.readSecureData(SecureStorage.userID);
    Map<String, dynamic> mm = {};
    mm["id"] = id;
    mm["avatar_base64"] = avatar;
    var json = jsonEncode(mm);
    try {
      http.Response response = await http.post(
        Uri.parse(
            "http://$domain/api/user/profile/update-avatar"), // TODO: API update profile
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json,
      );
      var body = jsonDecode(response.body);
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }
}
