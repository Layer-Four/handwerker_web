// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeVMAdapterImpl _$$TimeVMAdapterImplFromJson(Map<String, dynamic> json) =>
    _$TimeVMAdapterImpl(
      userId: json['userId'] as String?,
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
      projectId: (json['projectId'] as num?)?.toInt(),
      projectTitle: json['projectTitle'] as String?,
      serviceId: (json['serviceId'] as num?)?.toInt(),
      serviceTitle: json['serviceTitle'] as String?,
      customerName: json['customerName'] as String?,
      customerId: (json['customerId'] as num?)?.toInt(),
      type: $enumDecodeNullable(_$TimeEntryTypeEnumMap, json['type']) ??
          TimeEntryType.workOrder,
    );

Map<String, dynamic> _$$TimeVMAdapterImplToJson(_$TimeVMAdapterImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'pauseEnd': instance.pauseEnd?.toIso8601String(),
      'pauseStart': instance.pauseStart?.toIso8601String(),
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'duration': instance.duration,
      'projectId': instance.projectId,
      'projectTitle': instance.projectTitle,
      'serviceId': instance.serviceId,
      'serviceTitle': instance.serviceTitle,
      'customerName': instance.customerName,
      'customerId': instance.customerId,
      'type': _$TimeEntryTypeEnumMap[instance.type]!,
    };

const _$TimeEntryTypeEnumMap = {
  TimeEntryType.timeEntry: 'timeEntry',
  TimeEntryType.workOrder: 'workOrder',
};
