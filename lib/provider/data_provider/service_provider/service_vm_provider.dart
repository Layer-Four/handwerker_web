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
        throw Exception(
          'Error on loadServices, status-> ${response.statusCode}\n${response.data}',
        );
      }
      final data = response.data;
      final services = data.map<ServiceVM>((e) => ServiceVM.fromJson(e)).toList();
      state = services;
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      log('Exception on loadSerivce: $e');
    }
  }

  Future<List<UserDataShort>> getListUserService() async {
    final result = <UserDataShort>[];
    try {
      final response = await _api.getUserDataShort;
      if (response.statusCode != 200) {
        throw Exception(
          'Error on getListUserServices, status-> ${response.statusCode}\n${response.data}',
        );
      }
      final jsonResponse = response.data;
      final List data = (jsonResponse).map((e) => e).toList();
      data.map((e) => result.add(UserDataShort.fromJson(e)));
      return result;
    } on DioException catch (e) {
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log('Exception on getListUserService: $e');
      return [];
    }
  }

  Future<bool> deleteService(int serviceID) async {
    try {
      final response = await _api.deleteService(serviceID);
      if (response.statusCode != 200) {
        throw Exception(
          'Error on deleteService, status-> ${response.statusCode}\n${response.data}',
        );
      }
      loadServices();
      return true;
    } on DioException catch (e) {
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log('Exception on deleteService: $e');
      return false;
    }
  }

  Future<bool> createService(ServiceVM service) async {
    try {
      final response = await _api.postCreateService(service.toJson());
      if (response.statusCode != 200) {
        throw Exception(
          'Error on createService, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      loadServices();
      return true;
    } on DioException catch (e) {
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log('Exception on loadSerivce: $e');
      return false;
    }
  }

  Future<bool> updateService(ServiceVM service) async {
    try {
      final response = await _api.putUpdateService(service.toJson());
      if (response.statusCode != 200) {
        throw Exception(
          'Error on updateService, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      loadServices();
      return true;
    } on DioException catch (e) {
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log('Exception on updateService: $e');
      return false;
    }
  }
}
