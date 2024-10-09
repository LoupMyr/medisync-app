import 'package:flutter/material.dart';

class SnackbarComponent {
  static build(String text, BuildContext context) {
    return ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(text)));
  }
}