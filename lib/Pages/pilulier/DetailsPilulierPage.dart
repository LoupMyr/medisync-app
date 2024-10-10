import 'package:app/Controllers/MedicamentJourController.dart';
import 'package:app/Models/Enums/Jour.dart';
import 'package:app/Models/Enums/MomentJournee.dart';
import 'package:app/Models/MedicamentJour.dart';
import 'package:app/Models/Pilulier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailsPilulierPage extends StatefulWidget {
  const DetailsPilulierPage(
      {super.key, required this.title, required this.pilulier});
  final String title;
  final Pilulier pilulier;

  @override
  State<DetailsPilulierPage> createState() => _DetailsPilulierPageState();
}

class _DetailsPilulierPageState extends State<DetailsPilulierPage> {
  final MedicamentJourController _medicamentJourController =
      MedicamentJourController();
  List<Jour> days = [
    Jour.lundi,
    Jour.mardi,
    Jour.mercredi,
    Jour.jeudi,
    Jour.vendredi,
    Jour.samedi,
    Jour.dimanche
  ];
  List<MomentJournee> moments = [
    MomentJournee.matin,
    MomentJournee.midi,
    MomentJournee.soir
  ];

  Future<String> getPilulierDetails() async {
    List<MedicamentJour> list = await _medicamentJourController
        .getMedicamentJourByPilulierId(widget.pilulier.id);
    widget.pilulier.medicamentsJour = list;
    return '';
  }

  Column createDays() {
    List<Widget> result = [];
    for (Jour day in days) {
      result.add(
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            children: [
              Text(
                day.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              createMoments(day)
            ],
          ),
        ),
      );
    }
    return Column(children: result);
  }

  Row createMoments(Jour day) {
    List<Widget> result = [];
    for (MomentJournee moment in moments) {
      result.add(
        SizedBox(
          child: Column(children: [
            Text(
              moment.name,
              style: const TextStyle(fontSize: 15),
            ),
            createListMedocs(day, moment)
          ]),
        ),
      );
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, children: result);
  }

  Widget createListMedocs(Jour day, MomentJournee moment) {
    List<Widget> result = [];
    for (MedicamentJour medocJour in widget.pilulier.medicamentsJour) {
      if (medocJour.jour == day && medocJour.momentJournee == moment) {
        result.add(SizedBox(
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Center(
                child: Text(
                  medocJour.medicament.nom,
                  style: TextStyle(
                      decoration: medocJour.estPris
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
            ),
            onTap: () => swapEtat(medocJour),
          ),
        ));
      }
    }
    return Column(
      children: result,
    );
  }

  void swapEtat(MedicamentJour medocJour) async {
    setState(() {
      _medicamentJourController.patchEstPris(medocJour);
      medocJour.estPris = !medocJour.estPris;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPilulierDetails(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Column col = Column();
          if (snapshot.hasData) {
            col = createDays();
          } else if (snapshot.hasError) {
            col = const Column(
              children: <Widget>[
                Text('Une erreur est survenue'),
              ],
            );
          } else {
            col = const Column(
              children: <Widget>[
                Text('Chargement...'),
              ],
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(widget.title,
                  style: const TextStyle(color: Colors.white)),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [col],
                ),
              ),
            ),
          );
        });
  }
}
