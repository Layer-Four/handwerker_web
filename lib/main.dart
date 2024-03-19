import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:handwerker_web/provider/time_entry_provider/time_entry_provider.dart';
import 'package:handwerker_web/routes/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // if (ref.watch(timeEntryProvider).value == null) {
    //   ref.read(timeEntryProvider.notifier).loadTimeEntrys();
    // }

    return MaterialApp(
      theme: ThemeData().copyWith(
          cardTheme: const CardTheme(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
          ),
          primaryTextTheme: const TextTheme().apply(fontFamily: 'poppins'),
          textTheme: const TextTheme().apply(fontFamily: 'poppins'),
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
