import 'dart:convert';
import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/api/api.dart';
import '../../../models/time_models/time_dm/time_dm.dart';
import '../../../models/time_models/time_vm/time_vm.dart';
import '../../../models/users_models/user_data_short/user_short.dart';
import '../../user_provider/user_provider.dart';

// TODO: refactor Time Provider to CalendarEventData
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

  Future<bool> saveTimeEntry(TimeEntry entry) async {
    final json = entry.toJson();
    log(ref.watch(userProvider).userToken);
    log(jsonEncode(json));
    try {
      final response = await _api.postTimeEnty(json);
      if (response.statusCode != 200) {
        log('something went wrong on create TimeEntry -> ${response.data}');
        throw Exception('somthing went wrong, status ->${response.statusCode}\n${response.data}');
      }
      final jsonResponse = response.data;
      final data = jsonResponse.map((e) => TimeVMAdapter.fromJson(e)).toList();
      if (state.isNotEmpty) {
        final newstate = <TimeVMAdapter>[...state, data];
        state = newstate;
      }
      return true;
    } on DioException catch (e) {
      log('DioException -> $e');
      return false;
    } catch (e) {
      throw Exception(e);
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
