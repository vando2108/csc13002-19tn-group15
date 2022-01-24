import 'dart:convert';

import 'package:flashare/models/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class User {
  late String ID;
  late String Name;
  late String Email;
  late String Password;
  late String? avatarLink;
  late String? phoneNumber;
  late String? address;
  late double? rate;

  User({
    required this.ID,
    required this.Name,
    required this.Email,
    required this.Password,
    this.avatarLink,
    this.address,
    this.phoneNumber,
    this.rate,
  });

  User.fromJson(Map<String, dynamic> json)
      : ID = json["id"].toString(),
        Name = json["full_name"],
        Email = json["email"],
        Password = json["password_hash_code"],
        avatarLink = json["avatar_link"],
        phoneNumber = json["phone_number"],
        address = json["address"],
        rate = json["rate"];

  // ignore: non_constant_identifier_names
  Future<List> SignUp() async {
    var json =
        jsonEncode({'full_name': Name, 'email': Email, 'password': Password});
    try {
      String domain = dotenv.get('DOMAIN');
      http.Response response =
          await http.post(Uri.parse("http://$domain/api/user/auth/sign-up"),
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

  Future<List> SignIn() async {
    var json = jsonEncode({'email': Email, 'password': Password});
    try {
      String domain = dotenv.get('DOMAIN');
      http.Response response =
          await http.post(Uri.parse("http://$domain/api/user/auth/sign-in"),
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

Future<ApiResponse> FetchUser(String user_id) async {
  try {
    String url = "http://" +
        dotenv.env["DOMAIN"].toString() +
        "/api/user/profile/get/" +
        user_id;

    http.Response response =
        await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    var body = jsonDecode(response.body);
    return ApiResponse(true, body["data"]);
  } on Exception catch (_) {
    return ApiResponse(false, ["Can't connect to server"]);
  }
}
