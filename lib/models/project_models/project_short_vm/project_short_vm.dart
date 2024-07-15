import 'package:freezed_annotation/freezed_annotation.dart';
part 'project_short_vm.freezed.dart';
part 'project_short_vm.g.dart';

@freezed
class ProjectShortVM with _$ProjectShortVM {
  const factory ProjectShortVM({
    int? id,
    String? title,
    int? customerId,
  }) = _ProjectShortVM;

  factory ProjectShortVM.fromJson(Map<String, dynamic> json) => _$ProjectShortVMFromJson(json);
}
