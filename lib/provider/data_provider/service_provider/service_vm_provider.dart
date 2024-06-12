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
        log('Failed to delete service: ${response.statusCode}\n${response.data}');
        return false;
      }
      loadServices();
      return true;
    } on DioException catch (e) {
      log('DioException occurred: ${e.response?.statusCode}\n${e.message}');
      return false;
    } catch (e) {
      log('Exception occurred while deleting service with ID: $serviceID. Error: $e');
      return false;
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




// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../constants/api/api.dart';
// import '../../../models/service_models/service_vm/service_vm.dart';
// import '../../../models/users_models/user_data_short/user_short.dart';

// final serviceVMProvider = NotifierProvider<ServiceNotifier, List<ServiceVM>>(() => ServiceNotifier());

// class ServiceNotifier extends Notifier<List<ServiceVM>> {
//   final Api _api = Api();

//   @override
//   List<ServiceVM> build() {
//     log('Building initial service state');
//     loadServices();
//     return [];
//   }

//   Future<void> loadServices() async {
//     log('Loading services...');
//     try {
//       final response = await _api.getExecuteableServices;
//       if (response.statusCode != 200) {
//         log('Failed to load services. Status code: ${response.statusCode}, Response: ${response.data}');
//         return;
//       }
//       final data = response.data as List;
//       final services = data.map<ServiceVM>((e) => ServiceVM.fromJson(e)).toList();
//       log('Loaded services: ${services.length}');
//       state = services;
//     } catch (e) {
//       log('Exception during loading services: $e');
//       throw Exception(e);
//     }
//   }

//   Future<bool> deleteService(int serviceID) async {
//     log('Attempting to delete service with ID: $serviceID');
//     try {
//       final response = await _api.deleteService(serviceID);
//       if (response.statusCode != 200) {
//         log('Failed to delete service: ${response.statusCode}\n${response.data}');
//         return false;
//       }
//       // Ensure the state is updated after deletion
//       final updatedState = state.where((service) => service.id != serviceID).toList();
//       log('Updated state length: ${updatedState.length}');
//       state = updatedState;
//       log('Service deleted successfully with ID: $serviceID');
//       return true;
//     } on DioException catch (e) {
//       log('DioException occurred while deleting service: ${e.response?.statusCode}\n${e.message}');
//       return false;
//     } catch (e) {
//       log('Exception occurred while deleting service with ID: $serviceID. Error: $e');
//       return false;
//     }
//   }

//   Future<bool> createService(ServiceVM service) async {
//     log('Attempting to create service: ${service.toJson()}');
//     try {
//       final response = await _api.postCreateService(service.toJson());
//       if (response.statusCode != 200) {
//         log('Failed to create service: ${response.statusCode}\n${response.data}');
//         return false;
//       }
//       final dbService = ServiceVM.fromJson(response.data);
//       log('Service created successfully: ${dbService.toJson()}');
//       state = [...state, dbService];
//       return true;
//     } on DioException catch (e) {
//       log('DioException occurred while creating service: ${e.response?.statusCode}\n${e.message}');
//       return false;
//     } catch (e) {
//       log('Exception occurred while creating service: $e');
//       return false;
//     }
//   }

//   Future<bool> updateService(ServiceVM service) async {
//     log('Attempting to update service: ${service.toJson()}');
//     try {
//       final response = await _api.putUpdateService(service.toJson());
//       if (response.statusCode != 200) {
//         log('Failed to update service: ${response.statusCode}\n${response.data}');
//         return false;
//       }
//       state = [
//         for (final item in state)
//           if (item.id == service.id) service else item,
//       ];
//       log('Service updated successfully: ${service.toJson()}');
//       return true;
//     } on DioException catch (e) {
//       log('DioException occurred while updating service: ${e.response?.statusCode}\n${e.message}');
//       return false;
//     } catch (e) {
//       log('Exception occurred while updating service: $e');
//       return false;
//     }
//   }
// }
