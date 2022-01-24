import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class User {
  final String ID;
  final String Name;
  final String Email;
  final String Password;

  User(
      {required this.ID,
      required this.Name,
      required this.Email,
      required this.Password});

  // ignore: non_constant_identifier_names
  Future<List> SignUp() async {
    var json =
        jsonEncode({'full_name': Name, 'email': Email, 'password': Password});
    try {
      String url = dotenv.env["HOST"].toString() + "/api/user/auth/sign-up";
      http.Response response = await http.post(Uri.parse(url),
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
      String url = "http://" + dotenv.env["HOST"].toString() + "/api/user/auth/sign-in";
      http.Response response = await http.post(Uri.parse(url),
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
