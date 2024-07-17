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

class SettingsState {
  final Duration _messageDuration;
  final Dictionary _language;
  SettingsState({
    Dictionary? language,
    Duration? messageDuration,
  })  : _language = language ?? GermanLanguage(),
        _messageDuration = messageDuration ?? const Duration(seconds: 7);
  Duration get messsageDuration => _messageDuration;
  Dictionary get language => _language;
}

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

abstract class Dictionary {
  String get amount;
  String get checkInput;
  String get choosedImage;
  String get createEntry;
  String get createPassword;
  String get customerProject;
  String get date;
  String get description;
  String get dokumentation;
  String get duration;
  String get end;
  String get enterPassword;
  String get enterUserName;
  String get estimatedDuration;
  String get forgetPassword;
  String get login;
  String get logout;
  String get makePicture;
  String get material;
  String get pictureSucces;
  String get plsChooseBeginEnd;
  String get plsChooseDay;
  String get plsChooseProject;
  String get project;
  String get service;
  String get start;
  String get succes;
  String get sum;
  String get takePicture;
  String get documentationLabel;
  String get overView;
  String get timeoverview;
  String get taskOverview;
  String get consumables;
  String get plsChooseCustomerService;
  String get projectName;
  String get sessionHasEnded;
  String get workOrder;
  String get errorOnDeleteConsumable;
  String get noDataAvailable;
}

class EnglishLanguage extends Dictionary {
  @override
  String get amount => 'AMOUNT';

  @override
  String get checkInput => 'Please check your input';

  @override
  String get choosedImage => 'choosed image';

  @override
  String get createEntry => 'New entry';
  @override
  String get createPassword => 'Create new password';

  @override
  String get customerProject => 'COSTUMER/PROJECT';

  @override
  String get date => 'DATE';

  @override
  String get description => 'DESCRIPTION';

  @override
  String get dokumentation => 'DOCUMENTATION';

  @override
  String get duration => 'DURATIOM';

  @override
  String get end => 'END';

  @override
  String get enterPassword => 'Password';

  @override
  String get enterUserName => 'Please enter your username';

  @override
  String get estimatedDuration => 'estimated duration';

  @override
  String get forgetPassword => 'Forgot password';

  @override
  String get login => 'LOGIN';

  @override
  String get logout => 'LOGOUT';

  @override
  String get makePicture => 'make a pciture';

  @override
  String get material => 'MATERIAL';

  @override
  String get pictureSucces => ' picked picture';

  @override
  String get plsChooseBeginEnd => 'Please select a begin and end time';

  @override
  String get plsChooseDay => 'Please choose a Date';

  @override
  String get plsChooseProject => 'Please choose a project';

  @override
  String get project => 'Project';

  @override
  String get service => 'SERVICE';

  @override
  String get start => 'BEGIN';

  @override
  String get succes => 'Success';

  @override
  String get sum => 'SUM';

  @override
  String get takePicture => 'take a pciture';

  @override
  String get documentationLabel => 'Documentation';

  @override
  String get overView => 'OVERVIEW';

  @override
  String get timeoverview => 'Timeoverview';

  @override
  String get taskOverview => 'Jobs';

  @override
  String get consumables => 'Consumbales';

  @override
  String get plsChooseCustomerService => 'please choose CUSTOMER/PROJECT and SERVICE';

  @override
  String get projectName => 'Projectname';

  @override
  String get sessionHasEnded => 'Your session has ended.\nPlease login again';

  @override
  String get workOrder => 'Work order';

  @override
  String get errorOnDeleteConsumable => 'Error when attempting to delete the item: ';

  @override
  String get noDataAvailable => 'No data available';
}

class GermanLanguage extends Dictionary {
  @override
  String get amount => 'MENGE';
  @override
  String get checkInput => 'Bitte Kontrolliere deine Eingaben';

  @override
  String get choosedImage => 'Bild ausgewählt';

  @override
  String get createEntry => 'Eintrag erstellen';

  @override
  String get createPassword => 'Erstelle neues Password';

  @override
  String get customerProject => 'KUNDE/PROJEKT';

  @override
  String get date => 'TAG';

  @override
  String get description => 'BESCHREIBUNG';

  @override
  String get dokumentation => 'DOKUMENTATION';

  @override
  String get duration => 'DAUER';

  @override
  String get end => 'BIS';

  @override
  String get enterPassword => 'Password';

  @override
  String get enterUserName => 'Bitte gib dein Nutzternamen ein';

  @override
  String get estimatedDuration => 'Geschätze Dauer';

  @override
  String get forgetPassword => 'Passwort vergessen';

  @override
  String get login => 'Anmelden';

  @override
  String get logout => 'Ausloggen';

  @override
  String get makePicture => 'Foto machen';
  @override
  String get material => 'MATERIAL';

  @override
  String get pictureSucces => ' Bild ausgewählt';
  @override
  String get plsChooseBeginEnd => 'Bitte gib Start und eine Endzeit an';

  @override
  String get plsChooseDay => 'Bitte wähle ein anderes Datum';

  @override
  String get plsChooseProject => 'Bitte wähle einen Kunde und Projekt';

  @override
  String get project => 'Projekt';

  @override
  String get service => 'LEISTUNG';

  @override
  String get start => 'VON';

  @override
  String get succes => 'Erstellt!';

  @override
  String get sum => 'SUMME';

  @override
  String get takePicture => 'Bild wählen';

  @override
  String get documentationLabel => 'Dokumentation';

  @override
  String get overView => 'ÜBERSICHT';

  @override
  String get timeoverview => 'Zeitübersicht';

  @override
  String get taskOverview => 'Aufträge';

  @override
  String get consumables => 'Material';

  @override
  String get plsChooseCustomerService => 'Bitte wähle ein KUNDE/PROJEKT und LEISTUNG aus';

  @override
  String get projectName => 'Projektname';

  @override
  String get sessionHasEnded => 'Ihre Sitzung wurde Beendet.\nBitte melden sie sich erneut an';

  @override
  String get workOrder => 'Aufträge';

  @override
  String get errorOnDeleteConsumable => 'Es ist ein Fehler aufgetreten wärend dem Löschen von: ';

  @override
  String get noDataAvailable => 'Keine Daten gefunden';
}
