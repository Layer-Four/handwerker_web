import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:handwerker_app/constants/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/api/api.dart';
import '../../models/users_models/user_vm/user_vm.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, UserVM>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<UserVM> {
  final Api api = Api();
  late SharedPreferences _storage;

  UserNotifier() : super(const UserVM(userToken: '')) {
    _init();
  }

  Future<void> _init() async {
    _storage = await SharedPreferences.getInstance();
    String? token = _storage.getString('TOKEN');
    if (token != null && token.isNotEmpty) {
      state = state.copyWith(userToken: token);
    }
  }

  void userLogOut() {
    state = state.copyWith(userToken: '');
    deleteToken();
  }

  Future<bool> loginUser(
      {required String password,
      required String userName,
      String? mandatID}) async {
    final Map<String, dynamic> json = {
      'username': userName,
      'password': password,
      'mandant': mandatID ?? '1', // TODO: Review default value handling
    };
    try {
      final response = await api.postloginUser(json);
      if (response.statusCode == 200) {
        log(response.data.toString());
        final data = (response.data as Map);
        final userToken = data.values.first as String;
        setToken(token: userToken);
        state = state.copyWith(userToken: userToken);
        return true;
      } else {
        log('Request failed with status: ${response.statusCode}. Message: ${response.data}');
        return false;
      }
    } catch (e) {
      log('Error logging in: $e');
      return false;
    }
  }

  Future<void> setToken({required String token}) async {
    await _storage.setString('TOKEN', token);
  }

  void deleteToken() async {
    if (_storage.containsKey('TOKEN')) {
      await _storage.remove('TOKEN');
    }
  }
}
