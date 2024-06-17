import 'package:flutter/material.dart';

void bottomPopUpMessage(BuildContext context, String message,
    {bool showError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: showError? Duration(seconds: 2) : Duration(seconds: 5),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: showError ? Colors.red : Colors.green,
    ),
  );
}
