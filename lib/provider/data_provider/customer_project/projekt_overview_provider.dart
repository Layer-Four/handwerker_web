import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/api/api.dart';
import '../../../models/project_models/customer_projects_report_dm/customer_projects_report_dm.dart';

final projektReportProvider =
    NotifierProvider<ProjectOverViewNotifier, List<CustomerProjectsReportDM>>(
        () => ProjectOverViewNotifier());

class ProjectOverViewNotifier extends Notifier<List<CustomerProjectsReportDM>> {
  final Api _api = Api();
  @override
  List<CustomerProjectsReportDM> build() {
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
      final reports = data.map((e) => CustomerProjectsReportDM.fromJson(e)).toList();

      state = reports;
      return;
    } on DioException catch (e) {
      log('DioException ${e.message}');
    } catch (e) {
      log('Exception was thrown ad loadCustomerProjectReports ad projectReportProvider->\n$e');
      return;
    }
  }
}
