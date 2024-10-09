import 'package:app/Models/Pilulier.dart';
import 'package:flutter/material.dart';

class DetailsPilulierPage extends StatefulWidget {
  const DetailsPilulierPage({super.key, required this.title, required this.pilulier});
  final String title;
  final Pilulier pilulier;

  @override
  State<DetailsPilulierPage> createState() => _DetailsPilulierPageState();
}

class _DetailsPilulierPageState extends State<DetailsPilulierPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Details Pilulier'),
          ],
        ),
      ),
    );
  }
}