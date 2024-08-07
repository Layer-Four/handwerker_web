import 'package:freezed_annotation/freezed_annotation.dart';

import '../../consumable_models/project_consumable_model/project_consumable.dart';
import '../../service_models/service_project/service_project.dart';
import '../../time_models/project_time_model/project_time_entry.dart';
import '../project_state_model/project_state.dart';
part 'project_report_dm.freezed.dart';
part 'project_report_dm.g.dart';

@Freezed()
class ProjectRepotsDM with _$ProjectRepotsDM {
  const factory ProjectRepotsDM({
    @Default([]) List<ProjectConsumable> consumables,
    int? projectID,
    DateTime? dateOfStart,
    DateTime? dateOfTermination,
    String? projectDescription,
    String? projectName,
    double? projectRevenue,
    ProjectInfoState? projectState,
    @Default([]) List<ProjectTimeEntry> reportsList,
    @Default([]) List<ServiceProject> serviceList,
  }) = _ProjectRepotsDM;
  factory ProjectRepotsDM.fromJson(Map<String, dynamic> json) =>
      _$ProjectRepotsDMFromJson(json);
  const ProjectRepotsDM._();
}
