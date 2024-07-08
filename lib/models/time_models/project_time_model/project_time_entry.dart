import 'package:freezed_annotation/freezed_annotation.dart';
part 'project_time_entry.freezed.dart';
part 'project_time_entry.g.dart';

@freezed
class ProjectTimeEntry with _$ProjectTimeEntry {
  factory ProjectTimeEntry({
    DateTime? startTimeDate,
    String? workDescription,
    @Default([]) List<String> imagePathList,
  }) = _ProjectTimeEntry;
  factory ProjectTimeEntry.fromJson(Map<String, dynamic> json) => _$ProjectTimeEntryFromJson(json);
}
