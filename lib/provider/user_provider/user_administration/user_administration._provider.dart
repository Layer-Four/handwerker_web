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
      return data;
    } on DioException catch (e) {
      if (e.toString().contains('400')) {
        return {'error': 'duplicated user'};
      }
      log('DioException: status ${e.response?.statusCode}\n${e.message}');
    } catch (e) {
      if (e.toString().contains('400')) {}
      log('Error on createUser $e');
    }
    return {'error': 'duplicated user'};
  }

  Future<bool> deleteUser(String userID) async {
    try {
      final response = await _api.deleteUser(userID);
      if (response.statusCode != 200) {
        throw Exception(
          'Error on deleteUser, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      if (response.data.contains('User deleted successfully.')) {
        loadUserEntries();
      }
      final List<UserDataShort> newState = [];
      state.map((e) => {if (e.id != userID) newState.add(e)}).toList();
      state = newState;
      return true;
    } on DioException catch (e) {
      log('DioException: ${e.message}');
    } catch (e) {
      log('Error on deleteUser $e');
    }
    return false;
  }

  Future<void> loadUserEntries() async {
    try {
      final response = await _api.getUserDataShort;
      if (response.statusCode != 200) {
        throw Exception(
          'Error on loadUserEntries, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      final List data = response.data.map((e) => e).toList();
      final List<UserDataShort> users = data.map((e) => UserDataShort.fromJson(e)).toList();
      final newState = <UserDataShort>{...state, ...users}.toList();
      state = newState;
      return;
    } on DioException catch (e) {
      log('DioException: ${e.message}');
    } catch (e) {
      log('Error on loadUserEntries $e');
    }
  }

  Future<List<UserRole>> loadUserRoles() async {
    try {
      final response = await _api.getUserRoles;
      if (response.statusCode != 200) {
        throw Exception(
          'Error on loadUserRoles, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      final List data = response.data.map((e) => e).toList();
      return data.map((data) => UserRole.fromJson(data)).toList();
    } on DioException catch (e) {
      log('DioException: ${e.message}');
    } catch (e) {
      log('Error on loadUserRoles $e');
    }
    return [];
  }

  Future<Map> resetPassword(String name) async {
    try {
      final response = await _api.putResetPassword(name);
      if (response.statusCode != 200) {
        throw Exception(
          'Error on resetPassword, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      return response.data;
    } on DioException catch (e) {
      log('DioException: ${e.message}');
    } catch (e) {
      log('Error on resetPassword $e');
    }
    return {};
  }

  Future<bool> updateUser(UserDataShort user) async {
    final roles = user.roles.map((e) => e.name).toList();
    final Map<String, dynamic> userId = {'userId': user.id};
    final json = user.toJson();
    json.update('roles', (e) => e = roles);
    json.removeWhere((key, value) => key == 'id');
    json.addAll(userId);
    try {
      final response = await _api.putUpdateUser(json);
      if (response.statusCode != 200) {
        throw Exception(
          'Error on updateUser, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      loadUserEntries();
      return true;
    } on DioException catch (e) {
      log('DioException: ${e.message}');
    } catch (e) {
      log('Error on updateUser $e');
    }
    return false;
  }
}
