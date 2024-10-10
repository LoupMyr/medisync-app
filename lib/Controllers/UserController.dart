import 'package:app/Controllers/AbstractController.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserController extends AbstractController {
  Future<int> authUser(String email, String password) async {
    var bodyRequest =
        convert.jsonEncode({'email': email, 'password': password});
    http.Response response = await http.post(Uri.parse('$uri/api/auth'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: bodyRequest);
    if (response.statusCode == 201) {
      var body = convert.jsonDecode(response.body);
      String accessToken = body['token'];
      String id = body['data']['id'].toString();
      String email = body['data']['email'];
      await secureStorageService.writeKey('accessToken', accessToken);
      await secureStorageService.writeKey('id', id);
      await secureStorageService.writeKey('email', email);
    }
    return response.statusCode;
  }

  Future<int> registerUser(String email, String password, String pseudo) async {
    http.Response response = await http.post(Uri.parse('$uri/api/users'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: convert.jsonEncode(
            {'email': email, 'password': password, 'pseudo': pseudo}));
    return response.statusCode;
  }
}
