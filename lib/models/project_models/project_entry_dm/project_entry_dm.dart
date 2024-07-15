import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_entry_dm.freezed.dart';
part 'project_entry_dm.g.dart';

@freezed
class ProjectEntryDM with _$ProjectEntryDM {
  const factory ProjectEntryDM({
    String? title,
    String? dateOfStart,
    String? dateOfTermination,
    int? projectStatusId,
    int? customerId,
    String? description,
    int? id,
  }) = _ProjectEntryDM;

  factory ProjectEntryDM.fromJson(Map<String, dynamic> json) => _$ProjectEntryDMFromJson(json);
}
