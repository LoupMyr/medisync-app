import 'package:app/Controllers/AbstractController.dart';
import 'package:app/Models/Medicament.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MedicamentController extends AbstractController {

  Future<List<Medicament>> getMedicamentsByUserId() async {
    String? id = await secureStorageService.readKey("id");
    http.Response response = await http.get(
        Uri.parse('$uri/api/users/medicaments/$id'),
        headers: <String, String>{});
    List<Medicament> result = [];
    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);
      for (var elt in body) {
        Medicament medoc = Medicament.fromJson(elt);
        result.add(medoc);
      }
    }
    return result;
  }

  Future<int> postMedicament(Medicament medicament) async {
    String? id = await secureStorageService.readKey('id');
    var body = convert.jsonEncode({
      "nom": medicament.nom,
      "dateExpiration": medicament.date_expiration,
      "description": medicament.description,
      "stockDisponible": medicament.stock_dispo,
      "dosage": medicament.dosage,
      "limite": medicament.limite,
      "forme_pharmacotique": medicament.forme_pharmacotique,
      "avecOrdonnance": medicament.avecOrdonnance,
      "userId": id
    });
    http.Response response = await http
        .post(Uri.parse('$uri/api/medicaments/'), headers: <String, String>{
      'Content-Type': 'application/json',
    }, body: body);
    return response.statusCode;
  }
}
