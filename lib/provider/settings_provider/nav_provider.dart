import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MainView {
  home,
  timeEntry,
  projectCustomer,
  consumables,
  customer,
  projectManagement,
  users,
}

extension MainViewExtennsion on MainView {
  MainView? getMainview(String current) => switch (current) {
        'Home' => MainView.home,
        'Zeiteintrag' => MainView.timeEntry,
        'Berichte' => MainView.projectCustomer,
        'Verwaltung' => MainView.consumables,
        'Kunden' => MainView.customer,
        'Projekte' => MainView.projectManagement,
        'Mitarbeiter' => MainView.users,
        'Log Out' => null,
        _ => null,
      };
}

// TODO: set to home view
final mainNavProvider = StateProvider((ref) => MainView.consumables);
