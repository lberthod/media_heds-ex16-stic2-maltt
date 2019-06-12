import 'package:flutter/material.dart';

class WidgetUtils {
  static void displaySnackBar(ScaffoldState scaffold, String message,
      [Color color = Colors.green]) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: 1, milliseconds: 500),
    );
    scaffold.showSnackBar(snackBar);
  }
}

