import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_vm.freezed.dart';
part 'time_vm.g.dart';

@freezed
class TimeEntry with _$TimeEntry {
  const factory TimeEntry({
    @Default('') String timeEntryID,
    required String title,
    required DateTime startTime,
    DateTime? endTime,
    String? description,
    String? useForColor,
  }) = _TimeEntry;
  factory TimeEntry.fromJson(Map<String, dynamic> json) => _$TimeEntryFromJson(json);
}
