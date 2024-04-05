import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/api/api.dart';
import '../../models/users_models/user_vm/user_vm.dart';

final userProvider = AsyncNotifierProvider<UserNotifier, List<UserVM?>>(() => UserNotifier());

class UserNotifier extends AsyncNotifier<List<UserVM?>> {
  final Api api = Api();
  @override
  FutureOr<List<UserVM?>> build() => [];

  void addUser(UserVM user) async {
    final maybeUser = state.value;
    if (maybeUser != null) {
      state = AsyncValue.data([...state.value!, user]);
      return;
    }
    state = AsyncValue.data([user]);
  }

  void loadUsers() async {
    final response = await api.getProjectsDM;
    if (response.statusCode == 200) {
      final data = response.data;
      final x = data.map((e) => UserVM.fromJson(data));
      state = AsyncValue.data(x);
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
}
