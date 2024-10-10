import 'package:app/Controllers/AbstractController.dart';
import 'package:app/Models/MedicamentJour.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MedicamentJourController extends AbstractController {
  Future<List<MedicamentJour>> getMedicamentJourByPilulierId(int id) async {
    List<MedicamentJour> result = [];
    http.Response response = await http.get(
        Uri.parse('$uri/api/medicamentJour/medicaments/$id'),
        headers: <String, String>{});
    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);
      for (var elt in body) {
        try {
          MedicamentJour medoc = MedicamentJour.fromJson(elt);
          result.add(medoc);
        } catch (e) {
          print(e);
        }
      }
    }
    return result;
  }

  Future<int> patchEstPris(MedicamentJour medoc) async {
    http.Response response = await http.patch(
        Uri.parse('$uri/api/medicamentJour/estPris/${medoc.id}'),
        headers: <String, String>{"Content-Type": "application/json"},
        body: convert.jsonEncode({"estPris": medoc.estPris}));

    return response.statusCode;
  }
}
