import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
      cardTheme: const CardTheme(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
      ),
      primaryTextTheme: const TextTheme().apply(fontFamily: 'poppins'),
      textTheme: const TextTheme().apply(fontFamily: 'poppins'),
      primaryColor: Colors.amber,
      highlightColor: Colors.amber,
      focusColor: Colors.amber);
}
