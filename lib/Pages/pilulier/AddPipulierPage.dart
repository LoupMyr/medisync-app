import 'package:app/Components/SnackbarComponent.dart';
import 'package:app/Controllers/PilulierController.dart';
import 'package:flutter/material.dart';

class AddPilulierPage extends StatefulWidget {
  const AddPilulierPage({super.key, required this.title});
  final String title;

  @override
  State<AddPilulierPage> createState() => _AddPilulierPageState();
}

class _AddPilulierPageState extends State<AddPilulierPage> {
  final _formKey = GlobalKey<FormState>();
  String _nom = "";
  final PilulierController _pilulierController = PilulierController();

  void sendRequest() async {
    int statusCode = await _pilulierController.postPilulier(_nom);
    if (statusCode == 201) {
      SnackbarComponent.build("Pilulier créé avec succès", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title,
                  style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text('Nom : ')),
                    validator: (valeur) {
                      if (valeur == null || valeur.isEmpty) {
                        _nom = '';
                      } else {
                        _nom = valeur;
                      }
                      return null;
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendRequest();
                    }
                  },
                  child: const Text("Créer",
                      style: TextStyle(color: Colors.white)),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
