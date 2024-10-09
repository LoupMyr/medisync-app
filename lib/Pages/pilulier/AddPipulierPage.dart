import 'package:flutter/material.dart';

class AddPilulierPage extends StatefulWidget {
  const AddPilulierPage({super.key, required this.title});
  final String title;

  @override
  State<AddPilulierPage> createState() => _AddPilulierPageState();
}

class _AddPilulierPageState extends State<AddPilulierPage> {
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
            Text('Add Pilulier'),
          ],
        ),
      ),
    );
  }
}