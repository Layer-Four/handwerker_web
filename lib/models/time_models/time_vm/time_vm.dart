import 'package:freezed_annotation/freezed_annotation.dart';

import '../../project_models/project_short_vm/project_short_vm.dart';
import '../../service_models/service_vm/service_vm.dart';
import '../../users_models/user_data_short/user_short.dart';

part 'time_vm.freezed.dart';
part 'time_vm.g.dart';

@freezed
class TimeVMAdapter with _$TimeVMAdapter {
  const factory TimeVMAdapter({
    UserDataShort? user,
    required DateTime startTime,
    required DateTime endTime,
    DateTime? pauseEnd,
    DateTime? pauseStart,
    int? id,
    required DateTime date,
    String? description,
    int? duration,
    ProjectShortVM? project,
    ServiceVM? service,
    String? customerName,
    int? customerId,
    @Default(TimeEntryType.workOrder) TimeEntryType type,
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
}

enum TimeEntryType {
  timeEntry(0),
  workOrder(1);

  final int i;
  const TimeEntryType(this.i);
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
