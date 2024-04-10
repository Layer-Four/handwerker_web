import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/i10n/dictionary.dart';

final localizationProvider = StateProvider<Localizations>((ref) => Localizations.de);
final languageProvider = StateProvider((ref) {
  final local = ref.watch(localizationProvider);
  return switch (local) {
    Localizations.ar => ArabicDictionary(),
    Localizations.en => EnglishDictionary(),
    Localizations.es => SpainDictionary(),
    Localizations.be => BelarusianDictionary(),
    _ => GermanDictionary()
  };
});

enum Localizations { de, en, es, ar, be }

extension LocalLocalitaion on Localizations {
  Locale getLocal(localizationProvider) => switch (localizationProvider) {
        Localizations.ar => const Locale('ar'),
        Localizations.en => const Locale('en'),
        Localizations.es => const Locale('es'),
        Localizations.be => const Locale('be'),
        _ => const Locale('de')
      };
  List<Locale> get getAllLocalization => Localizations.values.map((e) => (Locale(e.name))).toList();
}
