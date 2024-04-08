import 'package:freezed_annotation/freezed_annotation.dart';
part 'time_dm.freezed.dart';
part 'time_dm.g.dart';

@freezed
class TimeEntry with _$TimeEntry {
  const factory TimeEntry({
    required DateTime date,
    int? id,
    int? duration,
    String? description,
    required DateTime endTime,
    DateTime? pauseEnd,
    DateTime? pauseStart,
    int? projectID,
    int? serviceID,
    required DateTime startTime,
    @Default('f7e8b09a-ac4f-4a30-a7c5-b6f829cff9aa') String userID,
  }) = _TimeEntry;
  factory TimeEntry.fromJson(Map<String, dynamic> json) => _$TimeEntryFromJson(json);
}
