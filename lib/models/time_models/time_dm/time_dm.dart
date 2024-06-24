import 'package:freezed_annotation/freezed_annotation.dart';

import '../time_vm/time_vm.dart';

part 'time_dm.freezed.dart';
part 'time_dm.g.dart';

@freezed
class TimeEntry with _$TimeEntry {
  const factory TimeEntry({
    required DateTime date,
    String? description,
    int? duration,
    required DateTime endTime,
    int? id,
    DateTime? pauseEnd,
    DateTime? pauseStart,
    int? projectId,
    int? serviceId,
    int? userServiceId,
    required DateTime startTime,
    @Default(1) int type,
    String? userId,
    int? customerId,
  }) = _TimeEntry;

  factory TimeEntry.fromJson(Map<String, dynamic> json) => _$TimeEntryFromJson(json);
  // @Default('f7e8b09a-ac4f-4a30-a7c5-b6f829cff9aa') String userID,

  const TimeEntry._();
  factory TimeEntry.fromTimeEntriesVM(TimeVMAdapter e) => TimeEntry(
        date: e.date,
        description: e.description,
        duration: e.duration,
        endTime: e.endTime,
        id: e.id,
        pauseEnd: e.pauseEnd,
        pauseStart: e.pauseStart,
        projectId: e.projectId,
        serviceId: e.serviceId,
        startTime: e.startTime,
        type: e.type.index,
        userId: e.userId,
        customerId: e.customerId,
      );
}
