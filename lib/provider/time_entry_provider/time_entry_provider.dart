import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/api/api.dart';
import '../../models/time_models/time_vm/time_entry_adapter.dart';
import '../../models/time_models/time_vm/time_vm.dart';

final timeEntryProvider = AsyncNotifierProvider<TimeEntryNotifier, EventSource?>(
  () => TimeEntryNotifier(),
);

class TimeEntryNotifier extends AsyncNotifier<EventSource?> {
  final Api api = Api();
  @override
  FutureOr<EventSource?> build() => EventSource();

  void loadTimeEntrys() async {
    try {
      final response = await api.getAllTimeEntrys;
      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        final entrys = data.map((e) => TimeEntryVM.fromJson(e)).toList();
        state = AsyncValue.data(entrys);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
