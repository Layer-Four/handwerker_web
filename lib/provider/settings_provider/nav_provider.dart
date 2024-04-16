import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MainView {
  home,
  timeEntry,
  projectCustomer,
  consumables,
  customer,
  users,
}

extension MainViewExtennsion on MainView {
  MainView? getMainview(String current) => switch (current) {
        'Home' => MainView.home,
        'Zeiteintrag' => MainView.timeEntry,
        'Kunde/Projekt' => MainView.projectCustomer,
        'Material' => MainView.consumables,
        'Kunden' => MainView.customer,
        'Mitarbeiter' => MainView.users,
        'Log Out' => null,
        _ => null,
      };
}

// TODO: set to home view
final mainNavProvider = StateProvider((ref) => MainView.consumables);
