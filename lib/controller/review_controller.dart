import 'dart:convert';

import 'package:flashare/utils/user_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ReviewController {
  Future<List> getReview({String? userId}) async {
    String id = await SecureStorage.readSecureData(SecureStorage.userID);
    if (userId != null) id = userId;
    try {
      String domain = dotenv.get('DOMAIN');
      http.Response response = await http.get(
        Uri.parse("http://$domain/api/review/get-reviews?uid=$id"),
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

  Future<List> addReview({
    required String receiver,
    required int rate,
    required String review,
  }) async {
    String id = await SecureStorage.readSecureData(SecureStorage.userID);
    var json = jsonEncode({
      "sender": id,
      "receiver": receiver,
      "rate": rate,
      "review": review,
    });
    print(json);

    try {
      String domain = dotenv.get('DOMAIN');
      http.Response response =
          await http.post(Uri.parse("http://$domain/api/review/add-review"),
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
