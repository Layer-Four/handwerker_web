import 'package:freezed_annotation/freezed_annotation.dart';

import '../../customer_models/customer_short_model/customer_short_dm.dart';
import '../projects_state_enum/project_state.dart';

part 'project_entry_vm.freezed.dart';
part 'project_entry_vm.g.dart';

@freezed
class ProjectEntryVM with _$ProjectEntryVM {
  const factory ProjectEntryVM({
    required String title,
    required DateTime start,
    required DateTime terminationDate,
    @Default(ProjectState.planning) ProjectState state,
    String? description,
    int? id,
    CustomerShortDM? customer,
  }) = _ProjectEntryVM;

  bool isProjectMinFilled() {
    if (customer != null && start.millisecondsSinceEpoch < terminationDate.millisecondsSinceEpoch) {
      return true;
    }
    return false;
  }

  factory ProjectEntryVM.fromJson(Map<String, dynamic> json) => _$ProjectEntryVMFromJson(json);
  const ProjectEntryVM._();
}
