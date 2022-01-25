import 'dart:convert';
import 'package:flashare/utils/user_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String domain = dotenv.get('DOMAIN');

class RequestController {
  Future<List> getRequestPending() async {
    try {
      String id = await SecureStorage.readSecureData(SecureStorage.userID);
      var json = jsonEncode({"user_id": id});
      http.Response response = await http.post(
        Uri.parse("http://$domain/api/request/get-pending"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json,
      );
      var body = jsonDecode(response.body);
      if (body['data'] == null) body['data'] = [];
      List data = [body["success"], body["data"]];
      return data;
    } catch (e) {
      return [false, "Can't connect to server"];
    }
  }

  Future<List> getRequestArchived() async {
    try {
      String id = await SecureStorage.readSecureData(SecureStorage.userID);
      var json = jsonEncode({"user_id": id});
      http.Response response = await http.post(
        Uri.parse("http://$domain/api/request/get-archieved"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json,
      );
      var body = jsonDecode(response.body);
      if (body['data'] == null) body['data'] = [];
      List data = [body["success"], body["data"]];
      return data;
    } catch (_) {
      return [false, "Can't connect to server"];
    }
  }

  Future<List> getRequestCancel() async {
    try {
      String id = await SecureStorage.readSecureData(SecureStorage.userID);
      var json = jsonEncode({"user_id": id});
      http.Response response = await http.post(
        Uri.parse("http://$domain/api/request/get-cancelled"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json,
      );
      var body = jsonDecode(response.body);
      if (body['data'] == null) body['data'] = [];
      List data = [body["success"], body["data"]];
      return data;
    } catch (_) {
      return [false, "Can't connect to server"];
    }
  }
}
