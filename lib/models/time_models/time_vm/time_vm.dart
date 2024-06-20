import 'package:freezed_annotation/freezed_annotation.dart';

import '../time_dm/time_dm.dart';

part 'time_vm.freezed.dart';
part 'time_vm.g.dart';

@freezed
class TimeVMAdapter with _$TimeVMAdapter {
  const factory TimeVMAdapter({
    String? userId,
    required DateTime startTime,
    required DateTime endTime,
    DateTime? pauseEnd,
    DateTime? pauseStart,
    int? id,
    required DateTime date,
    String? description,
    int? duration,
    int? projectId,
    String? projectTitle,
    int? serviceId,
    String? serviceTitle,
    String? customerName,
    int? customerId,
    @Default(TimeEntryType.workOrder) TimeEntryType type,

    // required int id,
    // required String userId,
    // int? projectId,
    // int? serviceId,
    // int? duration,
    // String? serviceTitle,
    // required DateTime date,
    // required DateTime startTime,
    // required DateTime endTime,
    // DateTime? pauseEnd,
    // DateTime? pauseStart,
    // String? description,
    // String? useForColor,
  }) = _TimeVMAdapter;

  factory TimeVMAdapter.fromJson(Map<String, dynamic> json) => _$TimeVMAdapterFromJson(json);
  const TimeVMAdapter._();

  String getDurationInHours() {
    if (duration == null) return '';
    final hours = duration! ~/ 60;
    final minutes = duration! % 60;
    if (minutes < 10) return '$hours:0$minutes';
    return '$hours:$minutes';
  }

  factory TimeVMAdapter.fromTimeEntriesVM(TimeEntry e) => TimeVMAdapter(
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
        type: TimeEntryTypeExtention.getType(e.type),
        userId: e.userId,
      );
}

enum TimeEntryType {
  timeEntry,
  workOrder,
}

extension TimeEntryTypeExtention on TimeEntryType {
  int get index => switch (this) {
        TimeEntryType.timeEntry => 0,
        TimeEntryType.workOrder => 1,
      };
  static TimeEntryType getType(int index) => switch (index) {
        0 => TimeEntryType.timeEntry,
        1 => TimeEntryType.workOrder,
        _ => throw Exception('No Type with this index Founded')
      };
}
