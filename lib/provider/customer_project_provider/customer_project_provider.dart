import 'dart:developer';

//import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/users_models/user_vm/user_vm.dart';
import '../../constants/api/api.dart';
import '../../models/users_models/user_data_short/user_short.dart';
//import 'package:http/http.dart' as http;

final customerProjectProvider = NotifierProvider<UserNotifier, UserVM>(() => UserNotifier());

// final authProvider = ChangeNotifierProvider<User>((ref) => User());

class UserNotifier extends Notifier<UserVM> {
  final Api api = Api();

  @override
  UserVM build() {
    api.getToken.then((value) {
      final token = value;
      if (token != null) {
        state = state.copyWith(userToken: token);
      }
    });
    return const UserVM(userToken: '');
  }

  void fetchInfos() async {
    //https://r-wa-happ-be.azurewebsites.net/api/project/read/all
    final response = await api.getAllProjects;
    log('Response: ${response.data}');
    if (response.statusCode == 200) {
      final data = response.data;
      final x = data.map((e) => UserVM.fromJson(data));
      state = x;
      log(data);
      log(x);
      return;
    }
  }

  void userLogOut() {
    state = state.copyWith(userToken: '');
    deleteToken();
  }

  Future<String?> getUserToken() async {
    final token = await api.getToken;
    if (token != null && token.isNotEmpty) {
      state = state.copyWith(userToken: token);
    }
    return token;
  }

// TODO: delete default option for mandant
  Future<bool> loginUser({
    required String passwort,
    required String userName,
    String? mandatID,
  }) async {
    final Map<String, dynamic> json = {
      'username': userName,
      'password': passwort,
      'mandant': mandatID ?? '1',
    };
    try {
      final response = await api.postloginUser(json);
      if (response.statusCode == 401) {
        log('user not authorized');
        return false;
      }
      if (response.statusCode == 200) {
        log(response.data.toString());
        final data = (response.data as Map);
        final userToken = data.values.first as String;
        // TODO: when token Exist load user with Token
        final newUser = state.copyWith(userToken: userToken);
        api.storeToken(userToken);
        // final userDate = http.get('www.abc/getUerdata', data: userToken);

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

  void setToken({required String token}) => api.storeToken(token);

  void deleteToken() => api.deleteToken();

  /// TODO: This Api calls not Users!!! and is deprecated.
  void loadUsers() async {
    final response = await api.getProjectsDM;
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
    try {} catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UserDataShort>> getListUserService() async {
    final result = <UserDataShort>[];
    try {
      // final response = await dio.get(url);
      final response = await api.getUserDataShort;
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
      data.map((e) => result.add(UserDataShort.fromJson(e))).toList();
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
