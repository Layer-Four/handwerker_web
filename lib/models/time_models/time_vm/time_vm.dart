import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_vm.freezed.dart';
part 'time_vm.g.dart';

@freezed
class TimeEntryVM with _$TimeEntryVM {
  const factory TimeEntryVM({
    @Default('') String timeEntryID,
    int? projectID,
    int? serviceID,
    int? duration,
    required String title,
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
    String? description,
    String? useForColor,
  }) = _TimeEntryVM;
  factory TimeEntryVM.fromJson(Map<String, dynamic> json) => _$TimeEntryVMFromJson(json);
}
