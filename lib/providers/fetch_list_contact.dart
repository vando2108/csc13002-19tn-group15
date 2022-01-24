import 'dart:convert';
import 'dart:developer';
import 'package:flashare/models/api.dart';
import 'package:flashare/utils/user_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Contact {
  late String Reciver;
  late String Name;
  late String Avatar;
  late String LastMessage;
  late String Time;

  Contact() {}

  void fromMap(mapData) {
    Reciver = mapData["uid"];
    Name = mapData["name"];
    Avatar = mapData["avatar_link"];
    LastMessage = mapData["last_message"];
    Time = "Time";
    DateTime time = DateTime.parse(mapData["time"]);
    final diff = DateTime.now().difference(time);
    if (diff.inDays > 0) {
      if (diff.inDays > 7) {
        int week = diff.inDays ~/ 7;
        Time = week.toString() + ((week > 1) ? " weeks" : " week");
        return;
      }
      Time = diff.inDays.toString() +
          ((diff.inDays > 1) ? " days ago" : " day ago");
    } else if (diff.inHours > 0) {
      Time = time.hour.toString();
    } else if (diff.inMinutes > 0) {
      Time = time.minute.toString();
    } else
      Time = "Just now";
  }
}

Future<ApiResponse> FetchListContact() async {
  final uid = await SecureStorage.readSecureData(SecureStorage.userID);
  try {
    http.Response response = await http.get(
        Uri.parse(
            "http://" + dotenv.env["HOST"].toString() + "/api/message/get-contacts?uid=" + uid),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    var body = jsonDecode(response.body);
    return ApiResponse(true, body["data"]);
  } on Exception catch (_) {
    return ApiResponse(false, ["Can't connect to server"]);
  }
}
