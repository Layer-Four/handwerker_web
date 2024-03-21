import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MainView {
  home,
  timeEntry,
  projectCustomer,
  consumables,
  users,
}

extension MainViewExtennsion on MainView {
  MainView? getMainview(String current) {
    return switch (current) {
      'Home' => MainView.home,
      'Zeiteintrag' => MainView.timeEntry,
      'Kunde/Projekt' => MainView.projectCustomer,
      'Material' => MainView.consumables,
      'Mitarbeiter' => MainView.users,
      'Log Out' => null,
      _ => null,
    };
  }
}

final mainNavProvider = StateProvider((ref) => MainView.users);
