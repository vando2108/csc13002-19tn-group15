import 'dart:convert';

import 'package:flashare/models/api.dart';
import 'package:flashare/utils/user_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Message {
  final String message;
  final String senderid;
  final String reciverid;
  final DateTime time;

  Message(this.message, this.senderid, this.reciverid, this.time);

  Message.fromJson(Map<String, dynamic> json)
      : message = json['content'],
        senderid = json['sender'],
        reciverid = json['receiver'],
        time = DateTime.parse(json['time']);
}

Future<ApiResponse> SendMessage(String receiver, String content) async {
  final uid = await SecureStorage.readSecureData(SecureStorage.userID);
  DateTime now = DateTime.now();
  String dateTime = now.toIso8601String() +
      "+0" +
      now.timeZoneOffset.inHours.toString() +
      ":00";
  var json = jsonEncode({
    "sender": uid,
    "receiver": receiver,
    "content": content,
    "time": dateTime
  });
  try {
    http.Response response = await http.post(
        Uri.parse("http://" +
            dotenv.env["DOMAIN"].toString() +
            "/api/chat/send"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json
        );
    var body = jsonDecode(response.body);
    return ApiResponse(true, body["data"]);
  } on Exception catch (_) {
    return ApiResponse(false, "Can't connect to server");
  }
}
