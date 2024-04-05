import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/api/url.dart';
import '../../models/project_models/project_vm/project_vm.dart';

final projectVMProvider =
    AsyncNotifierProvider<ProjectVMNotifer, List<ProjectVM>?>(() => ProjectVMNotifer());

class ProjectVMNotifer extends AsyncNotifier<List<ProjectVM>?> {
  @override
  List<ProjectVM>? build() => null;

  void loadpProject() async {
    final uri = const DbAdress().getProjects;
    try {
      final response = await Dio().get(uri.path);
      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        final projects = data.map<ProjectVM>((e) => ProjectVM.fromJson(e)).toList();
        state = AsyncValue.data(projects);
      }
      if (response.statusCode != 200) {
        log('request dismissed statuscode: ${response.statusCode}');
        return;
      }
    } catch (e) {
      throw Exception(e);
    }
    return;
  }
}
