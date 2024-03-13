import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MainView {
  home,
  timeEntry,
  docs,
  consumables,
  users,
}

final mainNavProvider = StateProvider((ref) => MainView.timeEntry);
