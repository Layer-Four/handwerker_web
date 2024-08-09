import 'dart:convert';
import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import '../../../constants/api/api.dart';
import '../../../models/customer_models/customer_short_model/customer_short_dm.dart';
import '../../../models/project_models/project_short_vm/project_short_vm.dart';
import '../../../models/service_models/service_vm/service_vm.dart';
import '../../../models/time_models/time_dm/time_dm.dart';
import '../../../models/time_models/time_vm/time_vm.dart';
import '../../../models/users_models/user_data_short/user_short.dart';
import '../../user_provider/user_administration/user_administration._provider.dart';

final timeVMProvider = NotifierProvider<TimeVMNotifier, List<CalendarEventData>>(
  () => TimeVMNotifier(),
);

class TimeVMNotifier extends Notifier<List<CalendarEventData>> {
  final Logger _log = Logger('TimeVMLogger');
  final Api _api = Api();
  List<UserDataShort> _workers = [];
  List<TimeVMAdapter> _timeEntries = [];
  @override
  List<CalendarEventData> build() {
    loadEvents();
    loadWorkers();
    return [];
  }

  List<UserDataShort> get workers => _workers;
  List<TimeVMAdapter> get entries => _timeEntries;

  void loadWorkers() {
    _log.info('load Workers');
    if (ref.watch(userAdministrationProvider).isEmpty) return;

    _workers = ref.watch(userAdministrationProvider);
    _log.fine('load workers? -> ${_workers.length}');
  }

  void loadTimesFromProject(int projectID) async {
    if (_workers.isEmpty) loadWorkers();
    try {
      final res = await _api.getAllTimeEntrys;
      if (res.statusCode != 200) {
        throw Exception(
          'Error on loadEvents, status-> ${res.statusCode}\n ${res.data}',
        );
      }
      final List<TimeVMAdapter> result = jsonToTimeVMAdapter(
        res.data.map((e) => e).toList(),
      );

      _timeEntries = result;
    } on DioException catch (e) {
      log('DioException: ${e.message}');
    } catch (e) {
      log('Exception on loadEvents: $e');
    }
    return;
  }

  Future<List<CalendarEventData<TimeVMAdapter>>> loadEvents() async {
    if (ref.watch(userAdministrationProvider).isEmpty) return [];
    List<UserDataShort> workers = ref.watch(userAdministrationProvider);

    try {
      final res = await _api.getAllTimeEntrys;
      if (res.statusCode != 200) {
        throw Exception(
          'Error on loadEvents, status-> ${res.statusCode}\n ${res.data}',
        );
      }
      final List data = res.data.map((e) => e).toList();
      final List<CalendarEventData<TimeVMAdapter>> result = [];

      for (Map<String, dynamic> e in data) {
        UserDataShort? user;
        if (workers.map((j) => j.id).toList().contains(e['userId'])) {
          user = workers.firstWhere((k) => k.id == e['userId']);
        }
        final project = ProjectShortVM(id: e['projectId'], title: e['projectTitle']);
        final service = ServiceVM(name: e['serviceTitle'], id: e['serviceId']);
        final object = TimeVMAdapter(
          date: DateTime.parse(e['date']),
          user: user,
          description: e['description'],
          duration: e['duration'],
          startTime: DateTime.parse(e['startTime']),
          endTime: DateTime.parse(e['endTime']),
          pauseEnd: e['pauseEnd'] == null ? null : DateTime.tryParse(e['pauseEnd']),
          pauseStart: e['pauseStart'] == null ? null : DateTime.tryParse(e['pauseStart']),
          id: e['id'],
          project: project,
          service: service,
          customerName: e['customerName'],
          type: TimeEntryType.values[e['type']],
        );
        if (object.customerName == null) {
          // log(object.toJson().toString());
        }
        result.add(CalendarEventData(
          title: object.customerName ?? 'Kein Kunde',
          date: object.date,
          description: object.description,
          startTime: object.startTime,
          endTime: object.endTime,
          event: object,
        ));
      }
      state = result;
      return result;
    } on DioException catch (e) {
      log('DioException: ${e.message}');
    } catch (e) {
      log('Exception on loadEvents: $e');
    }
    return [];
  }

  Future<bool> saveTimeEntry(TimeVMAdapter entry) async {
    // TODO: Work for finish Create TimeEntry
    final requestData = TimeEntry.fromTimeEntriesVM(entry);
    final json = requestData.toJson();
    json.removeWhere((key, value) => key == 'type');
    json.removeWhere((key, value) => key == 'id');
    json.removeWhere((key, value) => key == 'userServiceId');
    log(jsonEncode(json));
    try {
      final response = await _api.postTimeEnty(json);
      if (response.statusCode != 200) {
        throw Exception(
          'Error on saveTimeEntry, status-> ${response.statusCode}\n ${response.data}',
        );
      }

      loadEvents();
      return true;
    } on DioException catch (e) {
      log('DioException: ${e.message}');
    } catch (e) {
      log('Exception on saveTimeEntry: $e');
    }
    return false;
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
      log('DioException: ${e.message}');
    } catch (e) {
      log('Exception on getListUserService: $e');
    }
    return [];
  }

  Future<List<ProjectShortVM>> getProjectForCustomer(int customerId) async {
    try {
      final response = await _api.getProjectByCustomerID(customerId);
      if (response.statusCode != 200) {
        throw Exception(
          'Error on getProjectForCustomer, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      final List data = response.data.map((e) => e).toList();
      return data.map((e) => ProjectShortVM.fromJson(e)).toList();
    } on DioException catch (e) {
      log('DioException: ${e.message}');
    } catch (e) {
      log('Exception on getProjectForCustomer: $e');
    }
    return [];
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
      log('DioException: ${e.message}');
    } catch (e) {
      log('Exception on getProjectForCustomer: $e');
    }
    return [];
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
      log('DioException: ${e.message}');
    } catch (e) {
      log('Exception on getAllCustomer: $e');
    }
    return [];
  }

  Future<List<TimeVMAdapter>> loadTimeEntriesFromProject(int? projectID) async {
    _log.info('start load TimeEntries for Project Invoice preview');
    if (projectID == null) return [];

    final List<TimeVMAdapter> result = [];
    try {
      final res = await _api.getAllTimeEntrys;
      if (res.statusCode != 200) {
        throw Exception(
          'The Request on laodTimeEntriesFromProject was incorrect $res',
        );
      }
      final data = res.data.map((e) => e).toList();
      final List<TimeVMAdapter> entries = jsonToTimeVMAdapter(data);
      if (entries.isEmpty) {
        _log.shout('No Data in entries saved');
        return result;
      }
      result.addAll(entries.where((e) => (e.project!.id == projectID && e.type == TimeEntryType.timeEntry)));
    } on DioException catch (e) {
      _log.warning(
        '''DioException has occurred on loadTimeEntriesFromProject
        status was ${e.response?.statusCode}, the data is -> ${e.response?.data} 
        and the message was: s${e.message}''',
      );
    } catch (e) {
      _log.warning('Exception has occurred on loadTimeEntriesFromProject the message was: s$e');
    }
    return result;
  }

  List<TimeVMAdapter> jsonToTimeVMAdapter(List<dynamic> data) {
    final List<TimeVMAdapter> result = [];
    for (Map<String, dynamic> e in data) {
      UserDataShort? user;
      if (workers.map((j) => j.id).toList().contains(e['userId'])) {
        user = workers.firstWhere((k) => k.id == e['userId']);
      }
      final project = ProjectShortVM(
        id: e['projectId'],
        title: e['projectTitle'],
      );
      final service = ServiceVM(
        name: e['serviceTitle'],
        id: e['serviceId'],
      );
      final entry = TimeVMAdapter(
        date: DateTime.parse(e['date']),
        user: user,
        description: e['description'],
        duration: e['duration'],
        startTime: DateTime.parse(e['startTime']),
        endTime: DateTime.parse(e['endTime']),
        pauseEnd: e['pauseEnd'] == null ? null : DateTime.tryParse(e['pauseEnd']),
        pauseStart: e['pauseStart'] == null ? null : DateTime.tryParse(e['pauseStart']),
        id: e['id'],
        project: project,
        service: service,
        customerName: e['customerName'],
        type: TimeEntryType.values[e['type']],
      );

      result.add(entry);
    }
    return result;
  }
}
