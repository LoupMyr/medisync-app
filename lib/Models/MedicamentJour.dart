import 'package:app/Models/Enums/Jour.dart';
import 'package:app/Models/Enums/MomentJournee.dart';
import 'package:app/Models/Medicament.dart';

class MedicamentJour {
  int id;
  Medicament medicament;
  Jour jour;
  MomentJournee momentJournee;
  int quantite;
  bool estPris;

  MedicamentJour(this.id, this.medicament, this.jour, this.momentJournee,
      this.quantite, this.estPris);

  MedicamentJour.fromJson(Map tab)
      : id = int.parse(tab['id'].toString()),
        medicament = Medicament.fromJson(tab['medicament']),
        jour = Jour.fromValue(tab['journee'])!,
        momentJournee = MomentJournee.fromValue(tab['momentJournee'])!,
        quantite = int.parse(tab['quantite'].toString()),
        estPris = bool.parse(tab['estPris'].toString());
}
