import 'package:freezed_annotation/freezed_annotation.dart';

import '../../customer_models/customer_short_model/customer_short_dm.dart';

part 'project_entry_vm.freezed.dart';
part 'project_entry_vm.g.dart';

@freezed
class ProjectEntryVM with _$ProjectEntryVM {
  const factory ProjectEntryVM({
    required String title,
    required DateTime start,
    required DateTime terminationDate,
    @Default(ProjectState.onHold) ProjectState state,
    String? description,
    int? id,
    CustomerShortDM? customer,
  }) = _ProjectEntryVM;

  factory ProjectEntryVM.fromJson(Map<String, dynamic> json) => _$ProjectEntryVMFromJson(json);
  const ProjectEntryVM._();
}

enum ProjectState {
  start(3),
  finished(5),
  doing(6),
  onHold(7);

  final int value;

  const ProjectState(this.value);

  String get title => switch (value) {
        3 => 'Offen',
        5 => 'Geschlossen',
        6 => 'In Bearbeitung',
        7 => 'on Hold',
        _ => 'Kein Status ',
      };
}

extension ProjectStateExt on ProjectState {
  static ProjectState getStateFromTitle(String title) => switch (title) {
        'Offen' => ProjectState.start,
        'Geschlossen' => ProjectState.finished,
        'In Bearbeitung' => ProjectState.doing,
        'on Hold' => ProjectState.onHold,
        _ => throw UnimplementedError()
      };
}
