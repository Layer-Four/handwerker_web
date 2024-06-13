import 'package:freezed_annotation/freezed_annotation.dart';
part 'service_vm.freezed.dart';
part 'service_vm.g.dart';

@freezed
class ServiceVM with _$ServiceVM {
  const factory ServiceVM({
    required String name,
    int? id,
    required double hourlyRate,
  }) = _ServiceVM;

  factory ServiceVM.fromJson(Map<String, dynamic> json) => _$ServiceVMFromJson(json);
}
