import 'dart:convert';
import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/api/api.dart';
import '../../../models/customer_models/customer_short_model/customer_short_dm.dart';
import '../../../models/project_models/project_vm/project_vm.dart';
import '../../../models/service_models/service_vm/service_vm.dart';
import '../../../models/time_models/time_dm/time_dm.dart';
import '../../../models/time_models/time_vm/time_vm.dart';
import '../../../models/users_models/user_data_short/user_short.dart';

// TODO: refactor Time Provider to CalendarEventData or a TimeEntryState Object?
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
        throw Exception(
          'Error on loadEvents, status-> ${res.statusCode}\n ${res.data}',
        );
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
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log('Exception on loadEvents: $e');
      return [];
    }
  }

  Future<bool> saveTimeEntry(TimeVMAdapter entry) async {
    // TODO: Work for finish Create TimeEntry
    final requestData = TimeEntry.fromTimeEntriesVM(entry);
    final json = requestData.toJson();
    json.removeWhere((key, value) => key == 'type');
    json.removeWhere((key, value) => key == 'id');
    json.removeWhere((key, value) => key == 'userServiceId');
    json.removeWhere((key, value) => key == 'customerId');
    log(jsonEncode(json));
    try {
      final response = await _api.postTimeEnty(json);
      if (response.statusCode != 200) {
        throw Exception(
          'Error on saveTimeEntry, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      final jsonResponse = response.data;
      final data = jsonResponse.map((e) => TimeVMAdapter.fromJson(e)).toList();
      if (state.isNotEmpty) {
        final newstate = <TimeVMAdapter>[...state, data];
        state = newstate;
      }
      return true;
    } on DioException catch (e) {
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log('Exception on saveTimeEntry: $e');
      return false;
    }
  }

  Future<List<UserDataShort>> getListUserService() async {
    final result = <UserDataShort>[];
    try {
      final response = await _api.getUserDataShort;
      if (response.statusCode != 200) {
        throw Exception(
          'Error on getListUserService, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      final jsonResponse = response.data;
      final List data = (jsonResponse).map((e) => e).toList();
      data.map((e) => result.add(UserDataShort.fromJson(e))).toList();
      return result;
    } on DioException catch (e) {
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log('Exception on getListUserService: $e');
      return [];
    }
  }

  Future<List<ProjectVM>> getProjectForCustomer(int customerId) async {
    try {
      final response = await _api.getProjectByCustomerID(customerId);
      if (response.statusCode != 200) {
        throw Exception(
          'Error on getProjectForCustomer, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      final List data = response.data.map((e) => e).toList();
      // final projectFromCustomer = data.map((e) => ProjectVM.fromJson(e)).toList();

      return data.map((e) => ProjectVM.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log('Exception on getProjectForCustomer: $e');
      return [];
    }
  }

  Future<List<ServiceVM>> loadServiceByUserID(String userId) async {
    try {
      final response = await _api.getUserServiceByID(userId);
      if (response.statusCode != 200) {
        throw Exception(
          'Error on getProjectForCustomer, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      final List data = response.data.map((e) => e).toList();
      final serviceFromUser = data.map((e) => ServiceVM.fromJson(e)).toList();
      return serviceFromUser;
    } on DioException catch (e) {
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log('Exception on getProjectForCustomer: $e');
      return [];
    }
  }

  Future<List<CustomerShortDM>> getAllCustomer() async {
    try {
      final response = await _api.getListCustomer;
      if (response.statusCode != 200) {
        throw Exception(
          'Error on getAllCustomer, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      final result = <CustomerShortDM>[];
      response.data.map((e) => result.add(CustomerShortDM.fromJson(e))).toList();
      return result;
    } on DioException catch (e) {
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log('Exception on getAllCustomer: $e');
      return [];
    }
  }
}
