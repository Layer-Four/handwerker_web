import 'dart:core';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/api/api.dart';
import '../../../models/project_models/project_vm/project_vm.dart';

final projectVMProvider =
    AsyncNotifierProvider<ProjectVMNotifer, List<ProjectVM>?>(() => ProjectVMNotifer());

class ProjectVMNotifer extends AsyncNotifier<List<ProjectVM>?> {
  final Api api = Api();
  @override
  List<ProjectVM>? build() => null;

  void loadpProject() async {
    try {
      final response = await api.getAllProjects;
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          // TODO: implement logout logic!
          log('request dismissed unauthorized');
          return;
        }
        log('request dismissed statuscode: ${response.statusCode}');
        return;
      }
      final projects = response.data.map<ProjectVM>((e) => ProjectVM.fromJson(e)).toList();
      state = AsyncValue.data(projects);
      return;
      // } on DioException catch (e) {
      // throw Exception(e.toString());
    } catch (e) {
      throw Exception(e);
      // log(e.toString());
    }
  }
}
