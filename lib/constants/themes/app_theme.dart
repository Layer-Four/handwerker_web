import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
      cardTheme: const CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
      ),
      canvasColor: AppColor.kWhite,
      cardColor: AppColor.kWhite,
      // focusColor: AppColor.kTextfieldBorder,
      bottomAppBarTheme: const BottomAppBarTheme(color: AppColor.kPrimary),
      useMaterial3: null,
      fontFamily: 'poppins',
      primarySwatch: AppColor.materialColorPrimary,
      scaffoldBackgroundColor: AppColor.kWhite,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColor.kWhite,
        centerTitle: true,
        // primaryTextTheme: const TextTheme().apply(fontFamily: 'poppins'),
        // textTheme: const TextTheme().apply(fontFamily: 'poppins'),
        // primaryColor: Colors.amber,
        // highlightColor: Colors.amber,
        // focusColor: Colors.amber
      ));
}
