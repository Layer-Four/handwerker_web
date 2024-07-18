import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Center(child: Text(message, textAlign: TextAlign.center)),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
