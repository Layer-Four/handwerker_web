import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/api/api.dart';
import '../../../models/service_models/service_vm/service_vm.dart';
import '../../../models/users_models/user_data_short/user_short.dart';

final serviceVMProvider =
    AsyncNotifierProvider<ServiceNotifer, List<ServiceVM>?>(() => ServiceNotifer());

class ServiceNotifer extends AsyncNotifier<List<ServiceVM>?> {
  final Api _api = Api();
  @override
  List<ServiceVM>? build() => null;

  void loadServices() async {
    try {
      final response = await _api.getExecuteableServices;
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          // TODO: implement logout logic
          return;
        }
        log('something went wrong-> ${response.data}');
      }
      final data = response.data;
      final services = data.map<ServiceVM>((e) => ServiceVM.fromJson(e)).toList();
      state = AsyncValue.data(services);
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
          // TODO: implement userprovider logout
          // ref.read(userProvider.notifier).userLogOut();
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
}
