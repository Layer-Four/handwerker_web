import 'package:freezed_annotation/freezed_annotation.dart';

import '../../customer_models/customer_credential.dart';
import '../project_report_dm/project_report_dm.dart';
part 'customer_projects_report_dm.freezed.dart';
part 'customer_projects_report_dm.g.dart';

@freezed
class CustomerProjectsReportDM with _$CustomerProjectsReportDM {
  factory CustomerProjectsReportDM({
    required CustomerCredentialDM customerCredentials,
    required String customerName,
    // @Default(0.0) double customerRevenue,
    double? customerRevenue,
    @Default([]) List<ProjectRepotsDM> projectsList,
  }) = _CustomerProjectsReportDM;

  factory CustomerProjectsReportDM.fromJson(Map<String, dynamic> json) =>
      _$CustomerProjectsReportDMFromJson(json);

  const CustomerProjectsReportDM._();
}
