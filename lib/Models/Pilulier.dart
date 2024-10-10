import 'package:app/Models/MedicamentJour.dart';

class Pilulier {
  int id;
  String nom;
  List<MedicamentJour> medicamentsJour;

  Pilulier(this.id, this.nom, this.medicamentsJour);

  Pilulier.fromJson(Map tab)
      : id = int.parse(tab['id'].toString()),
        nom = tab['nom'],
        medicamentsJour = [];
}
