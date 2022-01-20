import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestController {
  Future<dynamic> getRequest({
    required String id,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(""),  // TODO: API GET MY REQUEST
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var body = jsonDecode(response.body);
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }

  Future<dynamic> addReview({
    required String senderId,
    required String receiverId,
    required double rate,
    required String review,
  }) async {
    var json = jsonEncode({
      "sender": senderId,
      "receiver": receiverId,
      "rate": rate,
      "review": review,
    });
    print(json);
    try {
      http.Response response = await http.post(
        Uri.parse(""), // TODO: API add reviews
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }, body: json,
      );
      var body = jsonDecode(response.body);
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }
}
