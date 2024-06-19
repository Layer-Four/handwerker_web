import 'dart:core';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/constants/api/api.dart';
import '/models/project_models/project_vm/project_vm.dart';

final projectVMProvider =
    AsyncNotifierProvider<ProjectVMNotifer, List<ProjectVM>?>(() => ProjectVMNotifer());

class ProjectVMNotifer extends AsyncNotifier<List<ProjectVM>?> {
  final Api _api = Api();
  @override
  List<ProjectVM>? build() => null;

  void loadpProject() async {
    try {
      final response = await _api.getProjectsDM;
      if (response.statusCode != 200) {
        throw Exception('Error on loadProject status: ${response.statusCode}\n${response.data}');
      }
      final List data = response.data;
      final projects = data.map<ProjectVM>((e) => ProjectVM.fromJson(e)).toList();
      state = AsyncValue.data(projects);
      return;
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      log('Exception on loadProject:\n$e');
    }
  }
}
