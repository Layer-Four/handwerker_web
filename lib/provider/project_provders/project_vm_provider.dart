import 'dart:core';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/api/api.dart';
import '../../models/project_models/project_vm/project_vm.dart';

final projectVMProvider =
    AsyncNotifierProvider<ProjectVMNotifer, List<ProjectVM>?>(() => ProjectVMNotifer());

class ProjectVMNotifer extends AsyncNotifier<List<ProjectVM>?> {
  final Api api = Api();
  @override
  List<ProjectVM>? build() => null;

  void loadpProject() async {
    try {
      //   final response = await api.getAllProjects;
      //   if (response.statusCode == 200) {
      //     final projects = data.map<ProjectVM>((e) => ProjectVM.fromJson(e)).toList();
      //     state = AsyncValue.data(projects);
      //   }
      //   if (response.statusCode != 200) {
      //     log('request dismissed statuscode: ${response.statusCode}');
      //     return;
      //   }
    } catch (e) {
      log(e.toString());
      // throw Exception(e);
    }
    return;
  }
}
