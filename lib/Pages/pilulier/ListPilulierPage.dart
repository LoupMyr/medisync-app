import 'package:app/Models/Pilulier.dart';
import 'package:app/Pages/pilulier/DetailsPilulierPage.dart';
import 'package:flutter/material.dart';

class ListPilulierPage extends StatefulWidget {
  const ListPilulierPage({super.key, required this.title});
  final String title;

  @override
  State<ListPilulierPage> createState() => _ListPilulierPageState();
}

class _ListPilulierPageState extends State<ListPilulierPage> {

  List<Pilulier> _piluliers = [];

  Future<String> getPiluliers() async {
    return '';
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPiluliers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Column col = Column();
          if (snapshot.hasData) {
            col = Column(
              children: [
                ...List.generate(
                  _piluliers.length,
                  (index) => InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPilulierPage(
                                title: 'MediSync - ${_piluliers[index].nom}',
                                pilulier: _piluliers[index]))),
                    child: SizedBox(
                      height: 100,
                      width: 200,
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(_piluliers[index].nom),
                              ],
                            ),
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
              child: Center(
                child: Column(
                  children: [
                    col,
                  ],
                ),
              ),
            ),
          );
        });
  }
}
