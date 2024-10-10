import 'package:app/Components/SnackbarComponent.dart';
import 'package:app/Controllers/MedicamentController.dart';
import 'package:app/Models/Medicament.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddMedicamentPage extends StatefulWidget {
  const AddMedicamentPage({super.key, required this.title});
  final String title;

  @override
  State<AddMedicamentPage> createState() => _AddMedicamentPageState();
}

class _AddMedicamentPageState extends State<AddMedicamentPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _mapMedicament = {
    'nom': '',
    'description': '',
    'stock': '',
    'dosage': '',
    'forme': '',
    'limite': ''
  };
  TextEditingController dateInput = TextEditingController();
  bool checkedValue = false;
  MedicamentController medicamentController = MedicamentController();

  void sendRequest() async {
    Medicament medicament = new Medicament(
        0,
        _mapMedicament['nom'],
        _mapMedicament['description'],
        dateInput.text,
        int.parse(_mapMedicament['stock']),
        _mapMedicament['forme'],
        int.parse(_mapMedicament['dosage']),
        checkedValue,
        int.parse(_mapMedicament['limite']));
    int statusCode = await medicamentController.postMedicament(medicament);
    if (statusCode == 201) {
      SnackbarComponent.build('Médicament ajouté avec succés', context);
    } else {
      SnackbarComponent.build('Une erreur est survenue', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        decoration:
                            const InputDecoration(label: Text('Nom : ')),
                        validator: (valeur) {
                          if (valeur == null || valeur.isEmpty) {
                            _mapMedicament['nom'] = '';
                          } else {
                            _mapMedicament['nom'] = valeur;
                          }
                          return null;
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        maxLines: 3,
                        decoration: const InputDecoration(
                            label: Text('Description : ')),
                        validator: (valeur) {
                          if (valeur == null || valeur.isEmpty) {
                            _mapMedicament['description'] = '';
                          } else {
                            _mapMedicament['description'] = valeur;
                          }
                          return null;
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            label: Text('Stock actuel : ')),
                        validator: (valeur) {
                          if (valeur == null || valeur.isEmpty) {
                            _mapMedicament['stock'] = '';
                          } else {
                            _mapMedicament['stock'] = valeur;
                          }
                          return null;
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            label: Text('Forme pharmacotique : ')),
                        validator: (valeur) {
                          if (valeur == null || valeur.isEmpty) {
                            _mapMedicament['forme'] = '';
                          } else {
                            _mapMedicament['forme'] = valeur;
                          }
                          return null;
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        decoration:
                            const InputDecoration(label: Text('Dosage : ')),
                        validator: (valeur) {
                          if (valeur == null || valeur.isEmpty) {
                            _mapMedicament['dosage'] = '';
                          } else {
                            _mapMedicament['dosage'] = valeur;
                          }
                          return null;
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        decoration:
                            const InputDecoration(label: Text('Limite : ')),
                        validator: (valeur) {
                          if (valeur == null || valeur.isEmpty) {
                            _mapMedicament['limite'] = '';
                          } else {
                            _mapMedicament['limite'] = valeur;
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      height: MediaQuery.of(context).size.width / 3,
                      child: Center(
                        child: TextField(
                          controller: dateInput,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today),
                              labelText: "Enter Date"),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                dateInput.text = formattedDate;
                              });
                            } else {}
                          },
                        ),
                      ),
                    ),
                    CheckboxListTile(
                      title: const Text("Avec ordonnance"),
                      value: checkedValue,
                      onChanged: (newValue) {
                        setState(() {
                          checkedValue = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    )
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    sendRequest();
                  }
                },
                child: const Text("Envoyer",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
