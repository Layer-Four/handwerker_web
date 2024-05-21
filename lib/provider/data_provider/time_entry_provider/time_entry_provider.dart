import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/api/api.dart';
import '../../../models/time_models/time_dm/time_dm.dart';
import '../../../models/time_models/time_vm/event_source.dart';
import '../../../models/time_models/time_vm/time_vm.dart';

final eventSourceProvider = NotifierProvider<EventSourceNotifier, EventSource?>(
  () => EventSourceNotifier(),
);

class EventSourceNotifier extends Notifier<EventSource?> {
  final Api _api = Api();
  @override
  EventSource? build() => EventSource();

  Future<EventSource?> loadTimeEntrys() async {
    try {
      final response = await _api.getAllTimeEntrys;
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          // TODO: implement singout logic
          log('request incompleted -> unauthorized');
          return null;
        }
        log('Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message');
        return null;
      }
      final List jsonresponse = response.data;
      final List data = jsonresponse.map((e) => e).toList();
      final entrys =
          data.map((e) => TimeVMAdapter.fromTimeEntriesVM(TimeEntry.fromJson(e))).toSet().toList();
      final events = EventSource(appointments: entrys);
      return events;
    } on DioException catch (e) {
      throw Exception(e);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<CalendarEventData>> loadEvents() async {
    try {
      final res = await _api.getAllTimeEntrys;
      if (res.statusCode != 200) {
        return [];
      }
      final List data = res.data.map((e) => e).toList();
      final List<CalendarEventData> result = data.map(
        (e) {
          final x = TimeVMAdapter.fromTimeEntriesVM(TimeEntry.fromJson(e));
          return CalendarEventData(
            title: x.customerName ?? '${x.projectTitle}/${x.serviceTitle}',
            date: x.date,
            event: x,
          );
        },
      ).toList();
      return result;
    } on DioException catch (e) {
      if (e.message != null && e.message!.contains('500')) {
        log('Catch on Dio Exception with code 500');
      }
      log('Catch Dio Exception');
    } catch (e) {
      log('Catch on Exception');
    }
    return [];
  }

  void saveTimeEntry(TimeEntry data) async {
    final dataJson = data.toJson();
    try {
      // print(json.encode(dataJson));
      final response = await _api.postTimeEnty(dataJson);
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          // TODO:logout user!
          return;
        }
        log('something went wrong on create TimeEntry -> ${response.data}');
        return;
      }
      final jsonResponse = response.data;
      log('json=> $jsonResponse');
      final data = jsonResponse.map((e) => TimeVMAdapter.fromJson(e)).toList();
      if (state!.appointments != null) {
        final newstate = EventSource(appointments: [...state!.appointments!, data]);
        state = newstate;
      }
      return;
    } on DioException catch (e) {
      log('DioException -> $e');
      return;
    } catch (e) {
      throw Exception(e);
      // "This exception was thrown because the response has a status code of 404 and RequestOptions.validateStatus was configured to throw for this status code.
      // The status code of 404 has the following meaning: "Client error - the request contains bad syntax or cannot be fulfilled"
      // Read more about status codes at https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
      // In order to resolve this exception you typically have either to verify and fix your request code or you have to fix the server code.
    }
  }
}
