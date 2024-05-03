import 'package:flutter/material.dart';

class AppColor {
  static Color kPrimaryButtonColor = const Color.fromARGB(255, 224, 142, 60);
  static Color kPrimary = const Color.fromARGB(255, 98, 98, 98);
  static Color kWhite = Colors.white;
  static Color kBlack = Colors.black;
  static Color kTextfieldBorder = const Color.fromARGB(255, 220, 217, 217);
  static Color kWhiteWOpacity = const Color.fromARGB(192, 255, 255, 255);
  static Color kBlue = Colors.blue;
  static Color kRed = Colors.red;
  Color get white => Colors.white;
  Color get black => Colors.black;
  static const appbarGreen = Color.fromARGB(255, 76, 141, 95);

  static const MaterialColor materialColorPrimary =
      MaterialColor(_materialprimary, <int, Color>{
    50: Color(0xFFECECEC),
    100: Color(0xFFD0D0D0),
    200: Color(0xFFB1B1B1),
    300: Color(0xFF919191),
    400: Color(0xFF7A7A7A),
    500: Color(_materialprimary),
    600: Color(0xFF5A5A5A),
    700: Color(0xFF505050),
    800: Color(0xFF464646),
    900: Color(0xFF343434),
  });
  static const int _materialprimary = 0xFF626262;

  static const MaterialColor materialprimaryAccent =
      MaterialColor(_materialprimaryAccentValue, <int, Color>{
    100: Color(0xFFF39797),
    200: Color(_materialprimaryAccentValue),
    400: Color(0xFFFF2525),
    700: Color(0xFFFF0C0C),
  });
  static const int _materialprimaryAccentValue = 0xFFEE6969;
}
