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
        log('user not authorized');
        return false;
      }
      if (response.statusCode == 200) {
        log(response.data.toString());
        final data = (response.data as Map);
        final userToken = data.values.first as String;
        final newUser = state.copyWith(userToken: userToken);
        _api.storeToken(userToken);

        if (newUser != state) {
          state = newUser;
          return true;
        }
      } else {
        log('Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message');
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }

  /// TODO: This Api calls not Users!!! and is deprecated.
  void loadUsers() async {
    try {
      final response = await _api.getProjectsDM;
      if (response.statusCode == 200) {
        final data = response.data;
        final x = data.map((e) => UserVM.fromJson(data));
        state = x;
        return;
      }
      if (response.statusCode != 200) {
        log('something went wrong by loadingUser ${response.data}');
        return;
      }
    } catch (e) {
      throw Exception(e);
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
