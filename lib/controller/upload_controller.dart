import 'dart:convert';
import 'package:flashare/utils/user_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String domain = dotenv.get('DOMAIN');

class UploadController {
  Future<dynamic> getItemUpload({required String id}) async {
    var json = jsonEncode({"id": id});
    print(json);

    try {
      http.Response response = await http.post(
          Uri.parse("http://localhost:8080/api/user/profile/change-password"),
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

  Future<List> uploadItem({
    required String name,
    required String category,
    required List<String> photosBase64,
    required String description,
    required DateTime dueDate,
  }) async {
    String id = await SecureStorage.readSecureData(SecureStorage.userID);
    print(dueDate);
    var json = jsonEncode({
      "title": name,
      "category": category,
      "description": description,
      "due_date": dueDate.toIso8601String(),
      "uploaded_by": id,
      "photos_base64": photosBase64,
    });
    print(json);

    try {
      http.Response response =
          await http.post(Uri.parse("http://$domain/api/item/upload"),
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
