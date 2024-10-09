import 'package:app/Controllers/AbstractController.dart';
import 'package:app/Models/Medicament.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

class MedicamentController extends AbstractController {
  
  List<Medicament> getMedicamentsFixtures() {
    return [
      new Medicament(
          0, 'Doliprane', 'Desc', DateTime.now(), 3, 'Oral', 1, false, 2),
      new Medicament(
          1, 'Advil', 'Desc', DateTime.now(), 16, 'Oral', 1, false, 5),
      new Medicament(
          2, 'Smecta', 'Desc', DateTime.now(), 2, 'Oral', 1, false, 1),
    ];
  }

  Future<List<Medicament>> getMedicamentsByUserId(String id) async {
    http.Response response = await http.get(
        Uri.parse('$uri/api/users/medicaments/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        });
    List<Medicament> result = [];
    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);
      for (var elt in body) {
        result.add(Medicament.fromJson(elt));
      }
    }
    return result;
  }

  Future<int> postMedicament(Medicament medicament) async {
    String? id = await secureStorageService.readKey('id');
    http.Response response = await http
        .post(Uri.parse('$uri/api/medicaments/'), headers: <String, String>{
      'Content-Type': 'application/json',
    }, body: {
      "nom": medicament.nom,
      "dateExpiration": DateFormat('yyyy-MM-dd').format(medicament.date_expiration),
      "description": medicament.description,
      "stockDisponible": medicament.stock_dispo,
      "dosage": medicament.dosage,
      "forme_pharmacotique": medicament.forme_pharmacotique,
      "avecOrdonnance": medicament.avecOrdonnance ? 1 : 0,
      "userId": id
    });
    return response.statusCode;
  }
}
