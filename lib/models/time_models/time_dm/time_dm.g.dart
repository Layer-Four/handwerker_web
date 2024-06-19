// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeEntryImpl _$$TimeEntryImplFromJson(Map<String, dynamic> json) =>
    _$TimeEntryImpl(
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      endTime: DateTime.parse(json['endTime'] as String),
      id: (json['id'] as num?)?.toInt(),
      pauseEnd: json['pauseEnd'] == null
          ? null
          : DateTime.parse(json['pauseEnd'] as String),
      pauseStart: json['pauseStart'] == null
          ? null
          : DateTime.parse(json['pauseStart'] as String),
      projectId: (json['projectId'] as num?)?.toInt(),
      userServiceId: (json['userServiceId'] as num?)?.toInt(),
      startTime: DateTime.parse(json['startTime'] as String),
      type: (json['type'] as num?)?.toInt() ?? 1,
      userId: json['userId'] as String?,
      customerId: (json['customerId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TimeEntryImplToJson(_$TimeEntryImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'duration': instance.duration,
      'endTime': instance.endTime.toIso8601String(),
      'id': instance.id,
      'pauseEnd': instance.pauseEnd?.toIso8601String(),
      'pauseStart': instance.pauseStart?.toIso8601String(),
      'projectId': instance.projectId,
      'userServiceId': instance.userServiceId,
      'startTime': instance.startTime.toIso8601String(),
      'type': instance.type,
      'userId': instance.userId,
      'customerId': instance.customerId,
    };
