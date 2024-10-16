import 'package:app/Controllers/MedicamentController.dart';
import 'package:app/Models/Medicament.dart';
import 'package:app/Pages/medicament/DetailsMedicamentPage.dart';
import 'package:flutter/material.dart';

class InventairePage extends StatefulWidget {
  const InventairePage({super.key, required this.title});
  final String title;

  @override
  State<InventairePage> createState() => _InventairePageState();
}

class _InventairePageState extends State<InventairePage> {
  final MedicamentController _medicamentController = MedicamentController();
  List<Medicament> _medicaments = [];

  Future<String> getMedicaments() async {
    _medicaments = await _medicamentController.getMedicamentsByUserId();
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMedicaments(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Column col = Column();
          if (snapshot.hasData) {
            col = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: 25)),
                ...List.generate(
                  _medicaments.length,
                  (index) => InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsMedicamentPage(
                                title: 'MediSync - ${_medicaments[index].nom}',
                                medicament: _medicaments[index]))),
                    child: Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(_medicaments[index].nom),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Quantité: ${_medicaments[index].stock_dispo.toString()}'),
                                IconButton(
                                    onPressed: () => setState(() {
                                          _medicaments[index].plusStock();
                                        }),
                                    icon: const Icon(Icons.add)),
                                IconButton(
                                    onPressed: () => setState(() {
                                          _medicaments[index].minusStock();
                                        }),
                                    icon: const Icon(Icons.remove)),
                                IconButton(
                                    onPressed: () => null,
                                    icon: const Icon(Icons.delete)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
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
              child: Center(child: col),
            ),
          );
        });
  }
}
