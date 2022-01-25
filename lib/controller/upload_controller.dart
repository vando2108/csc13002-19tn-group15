import 'dart:convert';
import 'package:flashare/utils/user_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String domain = dotenv.get('DOMAIN');

class UploadController {
  Future<List> getItemUpload() async {
    String id = await SecureStorage.readSecureData(SecureStorage.userID);

    try {
      http.Response response = await http.get(
        Uri.parse("http://$domain/api/item/fetch-uploaded-by?uid=$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var body = jsonDecode(response.body);
      if (body["data"] == null) body["data"] = [];
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }

  Future<List> uploadItem({
    required String name,
    required String category,
    required List<String> photosBase64,
    required String description,
    required DateTime dueDate,
  }) async {
    String id = await SecureStorage.readSecureData(SecureStorage.userID);
    // print(dueDate.toUtc());
    DateTime now = DateTime.now();

    String dateTime = dueDate.toIso8601String() +
        "+0" +
        now.timeZoneOffset.inHours.toString() +
        ":00";
    var json = jsonEncode({
      "title": name,
      "category": category,
      "description": description,
      "due_date": dateTime,
      // "due_date": dueDate.toUtc(),
      "uploaded_by": id,
      "photos_base64": photosBase64,
    });

    try {
      http.Response response =
          await http.post(Uri.parse("http://$domain/api/item/upload"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json);
      var body = jsonDecode(response.body);
      if (body["data"] == null) body["data"] = [];
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }

  Future<List> getListRequest({
    required String itemId,
  }) async {
    String id = await SecureStorage.readSecureData(SecureStorage.userID);
    var json = jsonEncode({
      'item_id': itemId,
    });

    try {
      http.Response response = await http.post(
          Uri.parse("http://$domain/api/request/get-item-request"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json);
      var body = jsonDecode(response.body);
      if (body['data'] == null) body['data'] = [];
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }

  Future<List> acceptRequest({
    required String requestId,
  }) async {
    String id = await SecureStorage.readSecureData(SecureStorage.userID);
    var json = jsonEncode({
      'request_id': requestId,
    });

    try {
      http.Response response = await http.post(
          Uri.parse("http://$domain/api/request/accept-request"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json);
      var body = jsonDecode(response.body);
      if (body['data'] == null) body['data'] = [];
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }

  Future<List> cancelRequest({
    required String requestId,
  }) async {
    String id = await SecureStorage.readSecureData(SecureStorage.userID);
    var json = jsonEncode({
      'request_id': requestId,
    });

    try {
      http.Response response = await http.post(
          Uri.parse("http://$domain/api/request/cancel-request"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json);
      var body = jsonDecode(response.body);
      if (body['data'] == null) body['data'] = [];
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }

  Future<List> markItemAsSent({
    required String itemId,
  }) async {
    String id = await SecureStorage.readSecureData(SecureStorage.userID);
    var json = jsonEncode({
      'item_id': itemId,
    });

    try {
      http.Response response =
          await http.post(Uri.parse("http://$domain/api/request/archieve-item"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json);
      var body = jsonDecode(response.body);
      if (body['data'] == null) body['data'] = [];
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }
}
