import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_entry_vm.freezed.dart';
part 'project_entry_vm.g.dart';

@freezed
class ProjectEntryVM with _$ProjectEntryVM {
  const factory ProjectEntryVM({
    String? title,
    String? dateOfStart,
    String? dateOfTermination,
    int? projectStatusId,
    int? customerId,
    String? description,
    @Default([]) List<String> kundenzuweisungOptions,
    @Default([]) List<String> statusOptions,
  }) = _ProjectEntryVM;

  factory ProjectEntryVM.fromJson(Map<String, dynamic> json) => _$ProjectEntryVMFromJson(json);
}