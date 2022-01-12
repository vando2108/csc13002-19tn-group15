import 'dart:convert';
import 'package:http/http.dart' as http;

class UploadController {
  Future<dynamic> getItemUpload({required String id}) async {
    var json = jsonEncode({"id": id});
    print(json);
    
    // Map<String, String> headers = {"Content-type": "application/json"};
    http.Response response = await http.post(
        Uri.parse("http://localhost:8080/api/user/profile/change-password"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json);
    var body = jsonDecode(response.body);
    if (response.statusCode == 200)
      return "";
    else
      return body["data"];
  }
}