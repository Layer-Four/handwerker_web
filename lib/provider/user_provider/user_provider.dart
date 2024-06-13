import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/api/api.dart';
import '../../models/users_models/user_vm/user_vm.dart';

final userProvider = NotifierProvider<UserNotifier, UserVM>(() => UserNotifier());

// final authProvider = ChangeNotifierProvider<User>((ref) => User());

class UserNotifier extends Notifier<UserVM> {
  final Api _api = Api();

  @override
  UserVM build() {
    _api.getToken.then((value) {
      if (value != null && value.isNotEmpty) {
        state = state.copyWith(userToken: value);
      }
    });
    return const UserVM(userToken: '');
  }

  void userLogOut() {
    state = state.copyWith(userToken: '');
    _api.deleteToken();
  }

  Future<bool> loginUser({
    required String password,
    required String userName,
    String? mandatID,
  }) async {
    final Map<String, dynamic> json = {
      'username': userName,
      'password': password,
      'mandant': mandatID ?? '1',
    };
    try {
      final response = await _api.postloginUser(json);
      if (response.statusCode != 200) {
        throw Exception(
          'something went wrong on loginUser: status-> ${response.statusCode}\n${response.data}',
        );
      }
      _api.storeToken(response.data['token']);
      state = state.copyWith(userToken: response.data['token']);
      log(state.userToken);
      return true;
    } catch (e) {
      log('Error on loginUser $e');
      return false;
    }
  }

  Future<bool> setNewPassword(String username, String oTP, String newPassword) async {
    final json = {
      'userName': username,
      'oldPassword': oTP,
      'newPassword': newPassword,
    };
    try {
      final response = await _api.putSetNewPassword(json);
      if (response.statusCode != 200) {
        throw Exception(
            'something went wrong by setNewPassword: status-> ${response.statusCode}\n${response.data}');
      }
      log(response.data);
      return true;
    } on DioException catch (e) {
      log('${e.message}');
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
