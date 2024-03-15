import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MainView {
  home,
  timeEntry,
  docs,
  consumables,
  users,
}

extension MainViewExtennsion on MainView {
  MainView? getMainview(String current) {
    return switch (current) {
      'Home' => MainView.home,
      'Zeiteintrag' => MainView.timeEntry,
      'Kunde/Projekt' => MainView.docs,
      'Material' => MainView.consumables,
      'Mitarbeiter' => MainView.users,
      'Log Out' => null,
      _ => null,
    };
  }
}

final mainNavProvider = StateProvider((ref) => MainView.users);
