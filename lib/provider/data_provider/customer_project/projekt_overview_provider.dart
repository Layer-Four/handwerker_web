import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/api/api.dart';
import '../../../models/project_models/project_report_dm/project_report_dm.dart';

final projektReportProvider = NotifierProvider<ProjectOverViewNotifier, List<ProjectRepotsDM>>(
    () => ProjectOverViewNotifier());

class ProjectOverViewNotifier extends Notifier<List<ProjectRepotsDM>> {
  final Api _api = Api();
  @override
  List<ProjectRepotsDM> build() {
    loadCustomerProjectReports();
    return [];
  }

  void loadCustomerProjectReports() async {
    try {
      final response = await _api.getAllCustomerProjectReports;
      if (response.statusCode != 200) {
        throw Exception(
            'loadCustomerProjectOverview dismissed-> status: ${response.statusCode}\n${response.data}');
      }
      final List data = response.data.map((e) => e as Map).toList();
      final List<ProjectRepotsDM> reports = data.map((e) => ProjectRepotsDM.fromJson(e)).toList();

      state = reports;
      return;
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      log('Exception was thrown ad loadCustomerProjectReports ad projectReportProvider->\n$e');
      return;
    }
  }
}
