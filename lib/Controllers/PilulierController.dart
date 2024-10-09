import 'package:app/Controllers/AbstractController.dart';
import 'package:app/Models/Pilulier.dart';

class PilulierController extends AbstractController {
  List<Pilulier> getPilulierFixtures(){
    return [
      new Pilulier(0, "Traitement 1"),
      new Pilulier(1, "Traitement 2"),
      new Pilulier(2, "Traitement 3"),
    ];
  }
}