import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_state.freezed.dart';
part 'project_state.g.dart';

@freezed
class ProjectInfoState with _$ProjectInfoState {
  factory ProjectInfoState({
    DateTime? createdAt,
    String? createdBy,
    DateTime? editedAt,
    String? editedBy,
    int? id,
    int? mandantID,
    String? mandant,
    String? projects,
    String? value,
  }) = _ProjectInfoState;
  factory ProjectInfoState.fromJson(Map<String, dynamic> json) => _$ProjectInfoStateFromJson(json);
}
