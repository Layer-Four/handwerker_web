import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/api/api.dart';
import '../../../models/time_models/time_dm/time_dm.dart';
import '../../../models/time_models/time_vm/time_vm.dart';
import '../../../models/users_models/user_data_short/user_short.dart';

final timeVMProvider = NotifierProvider<TimeVMNotifier, List<TimeVMAdapter>>(
  () => TimeVMNotifier(),
);

class TimeVMNotifier extends Notifier<List<TimeVMAdapter>> {
  final Api _api = Api();
  @override
  List<TimeVMAdapter> build() => [];

  Future<List<CalendarEventData<TimeVMAdapter>>> loadEvents() async {
    try {
      final res = await _api.getAllTimeEntrys;
      if (res.statusCode != 200) {
        return [];
      }
      final List data = res.data.map((e) => e).toList();
      final List<CalendarEventData<TimeVMAdapter>> result = data.map(
        (e) {
          final object = TimeVMAdapter.fromTimeEntriesVM(TimeEntry.fromJson(e));
          state.add(object);
          String title = object.customerName ?? 'Kein Kunde';
          return CalendarEventData(
            title: title,
            date: object.date,
            description: object.description,
            startTime: object.startTime,
            endTime: object.endTime,
            event: object,
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
        log('something went wrong on create TimeEntry -> ${response.data}');
        return;
      }
      final jsonResponse = response.data;
      log('json=> $jsonResponse');
      final data = jsonResponse.map((e) => TimeVMAdapter.fromJson(e)).toList();
      if (state.isNotEmpty) {
        final newstate = <TimeVMAdapter>[...state, data];
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

  Future<List<UserDataShort>> getListUserService() async {
    final result = <UserDataShort>[];
    try {
      final response = await _api.getUserDataShort;
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          return result;
        }
        return result;
      }
      final jsonResponse = response.data;
      final List data = (jsonResponse).map((e) => e).toList();
      data.map((e) => result.add(UserDataShort.fromJson(e))).toList();
      return result;
    } on DioException catch (e) {
      log('this error occurent-> $e');
      return result;
    } catch (e) {
      log('this error occurent-> $e');
      throw Exception(e);
    }
  }
}
