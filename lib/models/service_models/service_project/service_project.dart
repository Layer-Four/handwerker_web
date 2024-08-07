import 'package:freezed_annotation/freezed_annotation.dart';
part 'service_project.freezed.dart';
part 'service_project.g.dart';

@freezed
class ServiceProject with _$ServiceProject {
  factory ServiceProject({
    required String serviceName,
    required int serviceAmount,
    required double servicePrice,
  }) = _ServiceProject;
  factory ServiceProject.fromJson(Map<String, dynamic> json) =>
      _$ServiceProjectFromJson(json);
}
