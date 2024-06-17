import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/api/api.dart';
import '../../../models/users_models/user_data_short/user_short.dart';
import '../../../models/users_models/user_role/user_role.dart';

final userAdministrationProvider = NotifierProvider<UserAdministrationNotifer, List<UserDataShort>>(
    () => UserAdministrationNotifer());

class UserAdministrationNotifer extends Notifier<List<UserDataShort>> {
  final Api _api = Api();
  @override
  List<UserDataShort> build() {
    loadUserEntries();
    return [];
  }

  void clearState() => state = [];

  Future<Map<String, dynamic>> createUser({
    required UserRole role,
    required String name,
  }) async {
    final newUser = {
      'userName': name,
      'roles': [role.name],
    };
    try {
      final response = await _api.postCreateNewUser(newUser);
      if (response.statusCode != 200) {
        throw Exception('${response.statusCode} Invalid Api call ${response.data}');
      }
      loadUserEntries();
      final data = response.data;
      log(data.toString());
      return data;
    } on DioException catch (e) {
      if (e.toString().contains('400')) {
        return {'error': 'duplicated user'};
      }
      throw Exception('DioException-> ${e.message}');
    } catch (e) {
      if (e.toString().contains('400')) {
        return {'error': 'duplicated user'};
      }
      throw Exception(e);
    }
  }

  Future<bool> deleteUser(String userID) async {
    try {
      final response = await _api.deleteUser(userID);
      if (response.statusCode != 200) {
        throw Exception("can't delete User. status -> ${response.statusCode} : ${response.data}");
      }
      if (response.data.contains('User deleted successfully.')) {
        loadUserEntries();
      }
      final List<UserDataShort> newState = [];
      state.map((e) => {if (e.id != userID) newState.add(e)}).toList();
      state = newState;
      return true;
    } on DioException catch (e) {
      log('DioException ${e.message}');
      throw Exception(e.message);
    } catch (e) {
      log('General Exception on deleteUser \n$e');
      return false;
    }
  }

  Future<void> loadUserEntries() async {
    try {
      final response = await _api.getUserDataShort;
      if (response.statusCode != 200) {
        throw Exception(
          'Something went wrong on Request:\n statuscode-> ${response.statusCode} \n${response.data}',
        );
      }
      final List data = response.data.map((e) => e).toList();
      final List<UserDataShort> users = data.map((e) => UserDataShort.fromJson(e)).toList();
      final newState = <UserDataShort>{...state, ...users}.toList();
      state = newState;
      return;
    } on DioException catch (e) {
      if (e.message != null && e.message!.contains('statuscode-> 500')) {
        log('$e');
        throw Exception(e);
      }
    } catch (e) {
      throw Exception(e);
    }
    return;
  }

  Future<List<UserRole>> loadUserRoles() async {
    try {
      final response = await _api.getUserRoles;
      if (response.statusCode != 200) {
        throw Exception('${response.statusCode} Invalid statusCode check Api call');
      }
      final List data = response.data.map((e) => e).toList();
      return data.map((data) => UserRole.fromJson(data)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map> resetPassword(String name) async {
    try {
      final response = await _api.putResetPassword({'userName': name});
      if (response.statusCode != 200) {
        throw Exception(
            'Something went wrong on Request:\n ${response.statusCode} \n${response.data}');
      }
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> updateUser(UserDataShort user) async {
    final roles = user.roles.map((e) => e.name).toList();
    final Map<String, dynamic> userId = {'userId': user.id};
    final json = user.toJson();
    json.update('roles', (e) => e = roles);
    json.removeWhere((key, value) => key == 'id');
    json.addAll(userId);
    log(json.toString());

    try {
      final response = await _api.putUpdateUser(json);
      if (response.statusCode != 200) {
        throw Exception(
            'something went wrong on update User-> ${response.statusCode}\n${response.data}');
      }
      loadUserEntries();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
