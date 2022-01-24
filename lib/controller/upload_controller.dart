import 'dart:convert';
import 'package:http/http.dart' as http;

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

  Future<dynamic> uploadItem({required String name, required String category, required List<String> photosBase64, required String description, required DateTime dueDate, required String uploadedBy,}) async {
    var json = jsonEncode({
      "title": name,
      "category": category,
      "photos_base64": photosBase64,
      "description": description,
      "due_date": dueDate,
      "uploaded_by": uploadedBy,
    });
    print(json);

    try {
      http.Response response = await http.post(
          Uri.parse("http://localhost:8080/api/item/upload"),
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