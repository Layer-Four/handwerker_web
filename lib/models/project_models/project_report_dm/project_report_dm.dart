import 'package:freezed_annotation/freezed_annotation.dart';

import '../../consumable_models/consumable_vm/consumable_vm.dart';
import '../../service_models/service_vm/service_vm.dart';
part 'project_report_dm.freezed.dart';
part 'project_report_dm.g.dart';

@Freezed()
class ProjectRepotsDM with _$ProjectRepotsDM {
  const factory ProjectRepotsDM({
    required String customerName,
    List<ConsumableVM>? materials,
    required int projectID,
    required String projectName,
    List<ServiceVM>? services,
    String? state,
    String? timeRange,
    required int turnover,
  }) = _ProjectRepotsDM;
  factory ProjectRepotsDM.fromJson(Map<String, dynamic> json) => _$ProjectRepotsDMFromJson(json);
  const ProjectRepotsDM._();
}
