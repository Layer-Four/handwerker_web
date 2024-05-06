import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:handwerker_app/constants/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/api/api.dart';
import '../../models/users_models/user_vm/user_vm.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserVM>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<UserVM> {
  final Api api = Api();
  SharedPreferences? _storage;

  UserNotifier() : super(const UserVM(userToken: '')) {
    _initialize();
  }

  Future<void> _initialize() async {
    _storage = await SharedPreferences.getInstance();
    final token = await getUserToken();
    if (token != null && token.isNotEmpty) {
      state = state.copyWith(userToken: token);
    }
  }

  Future<String?> getUserToken() async => _storage?.getString('TOKEN');

  void userLogOut() async {
    await deleteToken();
    state = state.copyWith(userToken: '');
  }

  Future<bool> loginUser({
    required String password,
    required String userName,
    String? mandatID,
  }) async {
    final Map<String, dynamic> json = {
      'username': userName,
      'password': password,
      'mandant': mandatID ?? '1', // Providing a default value if mandatID is null
    };
    try {
      final response = await api.postloginUser(json);
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final userToken = data['token'];
        await setToken(token: userToken);
        state = state.copyWith(userToken: userToken);
        return true;
      } else if (response.statusCode == 401) {
        log('User not authorized');
        return false;
      } else {
        log('Request not completed: ${response.statusCode} Backend returned: ${response.data}');
        return false;
      }
    } catch (e) {
      log('Login error: $e');
      return false;
    }
  }

  Future<void> setToken({required String token}) async {
    await _storage?.setString('TOKEN', token);
  }

  Future<void> deleteToken() async {
    if (_storage!.containsKey('TOKEN')) {
      await _storage?.clear();
    }
  }
}
