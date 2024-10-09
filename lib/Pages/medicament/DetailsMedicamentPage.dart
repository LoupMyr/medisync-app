import 'package:app/Models/Medicament.dart';
import 'package:flutter/material.dart';

class DetailsMedicamentPage extends StatefulWidget {
  const DetailsMedicamentPage({super.key, required this.title, required this.medicament});
  final String title;
  final Medicament medicament;

  @override
  State<DetailsMedicamentPage> createState() => _DetailsMedicamentPageState();
}

class _DetailsMedicamentPageState extends State<DetailsMedicamentPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.medicament.nom),
            Text('${widget.medicament.stock_dispo} / ${widget.medicament.limite}'),
          ],
        ),
      ),
    );
  }
}