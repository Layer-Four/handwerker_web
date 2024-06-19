import 'package:freezed_annotation/freezed_annotation.dart';
part 'project_vm.freezed.dart';
part 'project_vm.g.dart';

@freezed
class ProjectVM with _$ProjectVM {
  const factory ProjectVM({
    required int id,
    String? title,
    int? customerId,
  }) = _ProjectVM;

  factory ProjectVM.fromJson(Map<String, dynamic> json) => _$ProjectVMFromJson(json);
}
