import 'dart:convert';

import 'package:flashare/models/api.dart';
import 'package:flashare/models/message.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> FetchListMessage(String user1, String user2) async {
  try {
    http.Response response = await http.get(
        Uri.parse(
            "http://" + dotenv.env["DOMAIN"].toString() + "/api/message/fetch-between?user1=" + user1 + "&user2=" + user2),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    var body = jsonDecode(response.body);
    return ApiResponse(true, body["data"]);
  } on Exception catch (_) {
    return ApiResponse(false, ["Can't connect to server"]);
  }
}