import 'package:app/Pages/medicament/AddMedicamentPage.dart';
import 'package:app/Pages/medicament/InventairePage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InventairePage(
                            title: 'MediSync - Votre Inventaire'))),
                child: const Text('Votre inventaire')),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddMedicamentPage(
                            title: 'MediSync - Ajouter un médicament'))),
                child: const Text('Ajouter un médicament'))
          ],
        ),
      ),
    );
  }
}
