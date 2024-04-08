// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeEntryVMImpl _$$TimeEntryVMImplFromJson(Map<String, dynamic> json) =>
    _$TimeEntryVMImpl(
      id: json['id'] as int?,
      userId: json['userId'] as String,
      projectId: json['projectId'] as int?,
      serviceId: json['serviceId'] as int?,
      duration: json['duration'] as int?,
      serviceTitle: json['serviceTitle'] as String?,
      date: DateTime.parse(json['date'] as String),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      pauseEnd: json['pauseEnd'] == null
          ? null
          : DateTime.parse(json['pauseEnd'] as String),
      pauseStart: json['pauseStart'] == null
          ? null
          : DateTime.parse(json['pauseStart'] as String),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$TimeEntryVMImplToJson(_$TimeEntryVMImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'projectId': instance.projectId,
      'serviceId': instance.serviceId,
      'duration': instance.duration,
      'serviceTitle': instance.serviceTitle,
      'date': instance.date.toIso8601String(),
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'pauseEnd': instance.pauseEnd?.toIso8601String(),
      'pauseStart': instance.pauseStart?.toIso8601String(),
      'description': instance.description,
    };
