import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/api/api.dart';
import '../../../models/time_models/time_dm/time_dm.dart';
import '../../../models/time_models/time_vm/time_entry_adapter.dart';
import '../../../models/time_models/time_vm/time_vm.dart';

final timeEntryProvider = NotifierProvider<TimeEntryNotifier, EventSource?>(
  () => TimeEntryNotifier(),
);

class TimeEntryNotifier extends Notifier<EventSource?> {
  final Api api = Api();
  @override
  EventSource? build() => null;

  Future<EventSource?> loadTimeEntrys() async {
    // Future.delayed(const Duration(seconds: 2)).then((_) => EventSource(
    //       appointments: [
    //         TimeEntryVM(
    //           startTime: DateTime(2024, 04, 08, 12),
    //           endTime: DateTime(2024, 04, 08, 13),
    //           title: 'Test',
    //           date: DateTime(2024, 04, 05),
    //         )
    //       ],
    //     ));
    try {
      final response = await api.getAllTimeEntrys;
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          log('request incompleted -> unauthorized');
          // TODO: implement singout logic
          return null;
        }
        log('Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message');
        return null;
      }
      // log('response.data -> ${response.data}');
      final List jsonresponse = response.data;
      // log('type of responsedata-> ${jsonresponse.runtimeType}');
      final List data = jsonresponse.map((e) => e).toList();
      // final List data = response.data.map((e) => e).toList;
      // final timeEntrys = data.map((e) => TimeEntryVM.fromJson(e)).toList();
      final entrys = data.map((e) => TimeEntryVM.fromJson(e)).toSet().toList();
      final events = EventSource(appointments: entrys);
      return events;
      // state = entrys;
      // state = AsyncValue.data(entrys);
      // } on DioException catch (e) {
      // log(e.toString());
      // throw Exception(e);
    } catch (error) {
      throw Exception(error);
      // log(error.toString());
    }
  }

  void saveEntry(TimeEntry timeEntry) {
    final viewmodel = TimeEntryVM(
      userId: timeEntry.userID,
      date: timeEntry.date,
      startTime: timeEntry.startTime,
      endTime: timeEntry.endTime,
    );
    if (state == null) {
      state = EventSource(appointments: [viewmodel]);
      return;
    }
    final oldState = state;
    final newState = EventSource(appointments: [...?oldState!.appointments, viewmodel]);
    state = newState;
  }
}
