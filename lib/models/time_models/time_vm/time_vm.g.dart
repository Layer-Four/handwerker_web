// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeVMAdapterImpl _$$TimeVMAdapterImplFromJson(Map<String, dynamic> json) =>
    _$TimeVMAdapterImpl(
      user: json['user'] == null
          ? null
          : UserDataShort.fromJson(json['user'] as Map<String, dynamic>),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      pauseEnd: json['pauseEnd'] == null
          ? null
          : DateTime.parse(json['pauseEnd'] as String),
      pauseStart: json['pauseStart'] == null
          ? null
          : DateTime.parse(json['pauseStart'] as String),
      id: (json['id'] as num?)?.toInt(),
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      project: json['project'] == null
          ? null
          : ProjectVM.fromJson(json['project'] as Map<String, dynamic>),
      service: json['service'] == null
          ? null
          : ServiceVM.fromJson(json['service'] as Map<String, dynamic>),
      customerName: json['customerName'] as String?,
      customerId: (json['customerId'] as num?)?.toInt(),
      type: $enumDecodeNullable(_$TimeEntryTypeEnumMap, json['type']) ??
          TimeEntryType.workOrder,
    );

Map<String, dynamic> _$$TimeVMAdapterImplToJson(_$TimeVMAdapterImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'pauseEnd': instance.pauseEnd?.toIso8601String(),
      'pauseStart': instance.pauseStart?.toIso8601String(),
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'duration': instance.duration,
      'project': instance.project,
      'service': instance.service,
      'customerName': instance.customerName,
      'customerId': instance.customerId,
      'type': _$TimeEntryTypeEnumMap[instance.type]!,
    };

const _$TimeEntryTypeEnumMap = {
  TimeEntryType.timeEntry: 'timeEntry',
  TimeEntryType.workOrder: 'workOrder',
};
