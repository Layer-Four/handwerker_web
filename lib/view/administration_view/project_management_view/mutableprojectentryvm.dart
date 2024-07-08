import '../../../models/project_entry_models/project_entry_vm/project_entry_vm.dart';

class MutableProjectEntryVM {
  String title;
  String dateOfStart;
  String dateOfTermination;
  int projectStatusId;
  int customerId;
  String description;
  int? id;

  MutableProjectEntryVM({
    required this.title,
    required this.dateOfStart,
    required this.dateOfTermination,
    required this.projectStatusId,
    required this.customerId,
    required this.description,
    this.id,
  });

  factory MutableProjectEntryVM.fromProjectEntryVM(ProjectEntryVM projectEntryVM) =>
      MutableProjectEntryVM(
        title: projectEntryVM.title ?? '',
        dateOfStart: projectEntryVM.dateOfStart ?? '',
        dateOfTermination: projectEntryVM.dateOfTermination ?? '',
        projectStatusId: projectEntryVM.projectStatusId ?? 0,
        customerId: projectEntryVM.customerId ?? 0,
        description: projectEntryVM.description ?? '',
        id: projectEntryVM.id,
      );

  ProjectEntryVM toProjectEntryVM() => ProjectEntryVM(
        title: title,
        dateOfStart: dateOfStart,
        dateOfTermination: dateOfTermination,
        projectStatusId: projectStatusId,
        customerId: customerId,
        description: description,
        id: id,
      );
}
