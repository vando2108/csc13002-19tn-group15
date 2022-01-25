import 'dart:convert';

import 'package:flashare/models/api.dart';
import 'package:flashare/utils/user_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Item {
  late String id;
  late String title;
  late String category;
  late List<String> photos_link;
  late String desc;
  late DateTime due_date;
  late String upload_by;
  late String status;

  Item(this.id, this.title, this.category, this.photos_link, this.desc,
      this.due_date, this.upload_by, this.status);

  Item.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("id")) {
      id = json["id"];
    } else {
      id = "";
    }
    if (json.containsKey("title")) {
      title = json["title"];
    } else {
      title = "";
    }
    if (json.containsKey("category")) {
      category = json["category"];
    } else {
      category = "";
    }
    if (json.containsKey("photos_link")) {
      final temp = json["photos_link"];
      photos_link = [];
      for (var it in temp) {
        photos_link.add(it.toString());
      }
    } else {
      photos_link = [];
    }
    if (json.containsKey("description")) {
      desc = json["description"];
    } else {
      desc = "";
    }
    if (json.containsKey("due_date")) {
      due_date = DateTime.parse(json["due_date"]);
    } else {
      due_date = DateTime.now();
    }
    if (json.containsKey("uploaded_by")) {
      upload_by = json["uploaded_by"];
    } else {
      upload_by = "";
    }
    if (json.containsKey("status")) {
      status = json["status"];
    } else {
      status = "open";
    }
  }
}

Future<ApiResponse> RequestItem(String item_id) async {
  final user_id = await SecureStorage.readSecureData(SecureStorage.userID);
  var json = jsonEncode({'user_id': user_id, 'item_id': item_id});
  try {
    String domain = dotenv.get('DOMAIN');
    http.Response response =
        await http.post(Uri.parse("http://$domain/api/request/send-request"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json);
    var body = jsonDecode(response.body);
    return ApiResponse(body["success"], body["data"]);
  } on Exception catch (_) {
    return ApiResponse(false, "Can't connect to server");
  }
}
