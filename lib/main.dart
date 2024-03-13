import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_web/routes/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
          cardTheme: CardTheme(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
          ),
          primaryTextTheme: TextTheme().apply(fontFamily: 'poppins'),
          textTheme: TextTheme().apply(fontFamily: 'poppins'),
          primaryColor: Colors.amber,
          highlightColor: Colors.amber,
          focusColor: Colors.amber),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('de'), // German
        Locale('ar') // - Arabic
      ],
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
