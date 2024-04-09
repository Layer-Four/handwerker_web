import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_vm.freezed.dart';
part 'time_vm.g.dart';

@freezed
class TimeVMAdapter with _$TimeVMAdapter {
  const factory TimeVMAdapter({
    required int id,
    required String userId,
    int? projectId,
    int? serviceId,
    int? duration,
    String? serviceTitle,
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
    DateTime? pauseEnd,
    DateTime? pauseStart,
    String? description,
    String? useForColor,
  }) = _TimeVMAdapter;
  factory TimeVMAdapter.fromJson(Map<String, dynamic> json) => _$TimeVMAdapterFromJson(json);
}
