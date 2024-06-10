import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MainView {
  home,
  timeEntry,
  projectCustomer,
  consumables,
  customer,
  projectManagement,
  performance,
  users,
}

extension MainViewExtension on MainView {
  static MainView? getMainview(String current) => switch (current) {
        'Home' => MainView.home,
        'Zeiteintrag' => MainView.timeEntry,
        'Kunden/Projekte' => MainView.projectCustomer,
        'Material' => MainView.consumables,
        'Kunden' => MainView.customer,
        'Projekte' => MainView.projectManagement,
        'Leistungen' => MainView.performance,
        'Rechte' => MainView.users,
        'Log Out' => MainView.home,
        _ => null,
      };
}

// TODO: !!!!! set to home view
final mainNavProvider = StateProvider((ref) => MainView.home);
