import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'constants/themes/app_theme.dart';
import 'provider/settings_provider/language_provider.dart';
import 'routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen(
    (record) {
      log('${record.level.name}: ${record.time}: ${record.message}');
    },
    onDone: () => throw Exception('Logger is done'),
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) => MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: ref.watch(localizationProvider).getAllLocalization,
        //  const [
        //   Locale('en'), // English
        //   Locale('es'), // Spanish
        //   Locale('de'), // German
        //   Locale('ar') // - Arabic
        // ],
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
      );
}
