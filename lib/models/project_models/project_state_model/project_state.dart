import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_state.freezed.dart';
part 'project_state.g.dart';

@freezed
class ProjectState with _$ProjectState {
  factory ProjectState({
    DateTime? createdAt,
    String? createdBy,
    DateTime? editedAt,
    String? editedBy,
    int? id,
    int? mandantID,
    String? mandant,
    String? projects,
    String? value,
  }) = _ProjectState;
  factory ProjectState.fromJson(Map<String, dynamic> json) => _$ProjectStateFromJson(json);
}
