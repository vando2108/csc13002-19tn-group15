import 'dart:convert';

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
  Future<String> SignUp() async {
    var json =
        jsonEncode({'full_name': Name, 'email': Email, 'password': Password});
    print(json);
    Map<String, String> headers = {"Content-type": "application/json"};
    http.Response response = await http.post(
        Uri.parse("http://192.168.1.8:8080/api/user/auth/sign-up"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json);
    var body = jsonDecode(response.body);
    if (response.statusCode == 200)
      return "";
    else
      return body["data"];
  }
}
