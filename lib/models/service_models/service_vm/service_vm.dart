import 'package:freezed_annotation/freezed_annotation.dart';
part 'service_vm.freezed.dart';
part 'service_vm.g.dart';

@freezed
class ServiceVM with _$ServiceVM {
  const factory ServiceVM({
    required String name,
    required int id,
  }) = _Service;

  factory ServiceVM.fromJson(Map<String, dynamic> json) => _$ServiceVMFromJson(json);
}
