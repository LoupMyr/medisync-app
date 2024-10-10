import 'package:app/Controllers/AbstractController.dart';
import 'package:app/Models/Pilulier.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PilulierController extends AbstractController {
  List<Pilulier> getPilulierFixtures() {
    return [
      Pilulier(0, "Traitement 1", []),
      Pilulier(1, "Traitement 2", []),
      Pilulier(2, "Traitement 3", []),
    ];
  }

  Future<List<Pilulier>> getPiluliers() async {
    String? id = await secureStorageService.readKey("id");
    http.Response response = await http.get(
        Uri.parse('$uri/api/users/piluliers/$id'),
        headers: <String, String>{});
    List<Pilulier> result = [];
    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);
      for (var elt in body) {
        Pilulier pilulier = Pilulier.fromJson(elt);
        result.add(pilulier);
      }
    }
    return result;
  }
}
