import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/api/api.dart';
import '../../../models/service_models/service_vm/service_vm.dart';
import '../../../models/users_models/user_data_short/user_short.dart';

final serviceVMProvider = NotifierProvider<ServiceNotifer, List<ServiceVM>>(() => ServiceNotifer());

class ServiceNotifer extends Notifier<List<ServiceVM>> {
  final Api _api = Api();
  @override
  List<ServiceVM> build() {
    loadServices();
    return [];
  }

  void loadServices() async {
    try {
      final response = await _api.getExecuteableServices;
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          log('something went wrong-> ${response.data}');
          return;
        }
        log('something went wrong-> ${response.data}');
      }
      final data = response.data;
      final services = data.map<ServiceVM>((e) => ServiceVM.fromJson(e)).toList();
      state = services;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UserDataShort>> getListUserService() async {
    final result = <UserDataShort>[];
    try {
      // final response = await dio.get(url);
      final response = await _api.getUserDataShort;
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          // ref.read(userProvider.notifier).userLogOut();
          log('something went wrong-> ${response.data}');
          return result;
        }
        return result;
      }
      final jsonResponse = response.data;
      final List data = (jsonResponse).map((e) => e).toList();
      data.map((e) {
        log(e.toString());
        result.add(UserDataShort.fromJson(e));
      }).toList();
      // result.addAll(projects);
      return result;
    } on DioException catch (e) {
      log('this error occurent-> $e');
      return result;
    } catch (e) {
      log('this error occurent-> $e');
      throw Exception(e);
    }
  }

  Future<bool> deleteService(int serviceID) async {
    try {
      final response = await _api.deleteService(serviceID);
      if (response.statusCode != 200) {
        throw Exception('deleteService dismiss-> status: ${response.statusCode}\n${response.data}');
      }
      loadServices();
      return true;
    } on DioException catch (e) {
      throw Exception('DioException occurent dio status-> ${e.response?.statusCode}\n${e.message}');
    } catch (e) {
      log('Exception when trying to delete row with ID: $serviceID: $e');
      return false;
      // throw Exception(e);
    }
  }

  Future<bool> createService(ServiceVM service) async {
    try {
      final response = await _api.postCreateService(service.toJson());
      if (response.statusCode != 200) {
        throw Exception('createService dismiss-> status: ${response.statusCode}\n${response.data}');
      }
      final dbService = ServiceVM.fromJson(response.data);
      log(dbService.toJson().toString());
      loadServices();
      return true;
    } on DioException catch (e) {
      throw Exception('DioException occurent dio status-> ${e.response?.statusCode}\n${e.message}');
    } catch (e) {
      log('Exception on createService: $e');
      return false;
    }
  }

  Future<bool> updateService(ServiceVM service) async {
    try {
      final response = await _api.putUpdateService(service.toJson());
      if (response.statusCode != 200) {
        throw Exception('updateService dismiss-> status: ${response.statusCode}\n${response.data}');
      }
      loadServices();
      return true;
    } on DioException catch (e) {
      throw Exception('DioException occurent dio status-> ${e.response?.statusCode}\n${e.message}');
    } catch (e) {
      log('Exception on createService: $e');
      return false;
    }
  }
}
