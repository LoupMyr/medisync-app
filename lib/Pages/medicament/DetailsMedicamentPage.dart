import 'package:app/Models/Medicament.dart';
import 'package:flutter/material.dart';

class DetailsMedicamentPage extends StatefulWidget {
  const DetailsMedicamentPage(
      {super.key, required this.title, required this.medicament});
  final String title;
  final Medicament medicament;

  @override
  State<DetailsMedicamentPage> createState() => _DetailsMedicamentPageState();
}

class _DetailsMedicamentPageState extends State<DetailsMedicamentPage> {
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
            Image.network(
              'https://website.cinetpay.ci/images/empty.jpg',
              height: 150,
              width: 200,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.medicament.nom,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(widget.medicament.description),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            Text(
                'Quantité : ${widget.medicament.stock_dispo} / Limite: ${widget.medicament.limite}'),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Text("Dosage: ${widget.medicament.dosage}"),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Disponible sans ordonnance: "),
                Icon(
                    widget.medicament.avecOrdonnance
                        ? Icons.close
                        : Icons.check,
                    color: widget.medicament.avecOrdonnance
                        ? Colors.red
                        : Colors.green)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
