import 'package:flutter/material.dart';

void bottomPopUpMessage(BuildContext context, String message,
    {bool showError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: showError ? Colors.red : Colors.green,
    ),
  );
}
