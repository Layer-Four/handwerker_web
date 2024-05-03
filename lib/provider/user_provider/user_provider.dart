import 'dart:developer';

// Importing necessary packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/api/api.dart';
import '../../models/users_models/user_data_short/user_short.dart';
import '../../models/users_models/user_vm/user_vm.dart';

// Provider definition using StateNotifierProvider
final userProvider =
    StateNotifierProvider<UserNotifier, UserVM>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<UserVM> {
  final Api api = Api();
  late SharedPreferences _storage;

  // Constructor initializing the StateNotifier with an initial state
  UserNotifier() : super(const UserVM(userToken: '')) {
    _initialize();
  }

  // Initialize SharedPreferences and load the token if available
  Future<void> _initialize() async {
    _storage = await SharedPreferences.getInstance();
    String? token = _storage.getString('TOKEN');
    if (token != null && token.isNotEmpty) {
      state = UserVM(userToken: token);
    }
  }

  // Method to log out the user, clearing the token
  void userLogOut() {
    state = state.copyWith(userToken: '');
    deleteToken();
  }

  // Method to retrieve the user token from SharedPreferences
  Future<String?> getUserToken() async {
    String? token = _storage.getString('TOKEN');
    if (token != null && token.isNotEmpty) {
      state = state.copyWith(userToken: token);
    }
    return token;
  }

  // Method to login user with username and password
  Future<bool> loginUser({
    required String passwort,
    required String userName,
    String? mandatID,
  }) async {
    final Map<String, dynamic> json = {
      'username': userName,
      'password': passwort,
      'mandant':
          mandatID ?? '1', // Providing a default value if mandatID is null
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

  // Method to save user token to SharedPreferences
  Future<void> setToken({required String token}) async {
    await _storage.setString('TOKEN', token);
  }

  // Method to delete the user token from SharedPreferences
  Future<void> deleteToken() async {
    await _storage.remove('TOKEN');
  }

  // Method to fetch a list of user data as UserDataShort models
  Future<List<UserDataShort>> getListUserService() async {
    List<UserDataShort> result = [];
    try {
      final response = await api.getUserDataShort;
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        result = data
            .map((e) => UserDataShort.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 401) {
        userLogOut();
      }
      return result;
    } catch (e) {
      log('Error fetching user data: $e');
      return result;
    }
  }
}
