import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/api/api.dart';
import '../../models/time_models/time_vm/time_entry_adapter.dart';
import '../../models/time_models/time_vm/time_vm.dart';

final timeEntryProvider = NotifierProvider<TimeEntryNotifier, EventSource?>(
  () => TimeEntryNotifier(),
);

class TimeEntryNotifier extends Notifier<EventSource?> {
  final Api api = Api();
  @override
  EventSource? build() => null;

  Future<EventSource?> loadTimeEntrys() async =>
      Future.delayed(const Duration(seconds: 2)).then((_) => EventSource(
            appointments: [
              TimeEntryVM(
                startTime: DateTime(2024, 04, 05, 12),
                endTime: DateTime(2024, 04, 05, 13),
                title: 'Test',
                date: DateTime(2024, 04, 05),
              )
            ],
          ));
  // try {
  //   final response = await api.getAllTimeEntrys;
  //   if (response.statusCode == 200) {
  //     final entrys = data.map((e) => TimeEntryVM.fromJson(e)).toList();
  //     state = AsyncValue.data(entrys);
  //   }
  // } catch (e) {
  //   throw Exception(e);
  // }
}
