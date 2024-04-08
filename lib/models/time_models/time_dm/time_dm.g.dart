// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeEntryImpl _$$TimeEntryImplFromJson(Map<String, dynamic> json) =>
    _$TimeEntryImpl(
      date: DateTime.parse(json['date'] as String),
      id: json['id'] as int?,
      duration: json['duration'] as int?,
      description: json['description'] as String?,
      endTime: DateTime.parse(json['endTime'] as String),
      pauseEnd: json['pauseEnd'] == null
          ? null
          : DateTime.parse(json['pauseEnd'] as String),
      pauseStart: json['pauseStart'] == null
          ? null
          : DateTime.parse(json['pauseStart'] as String),
      projectID: json['projectID'] as int?,
      serviceID: json['serviceID'] as int?,
      startTime: DateTime.parse(json['startTime'] as String),
      userID:
          json['userID'] as String? ?? 'f7e8b09a-ac4f-4a30-a7c5-b6f829cff9aa',
    );

Map<String, dynamic> _$$TimeEntryImplToJson(_$TimeEntryImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'id': instance.id,
      'duration': instance.duration,
      'description': instance.description,
      'endTime': instance.endTime.toIso8601String(),
      'pauseEnd': instance.pauseEnd?.toIso8601String(),
      'pauseStart': instance.pauseStart?.toIso8601String(),
      'projectID': instance.projectID,
      'serviceID': instance.serviceID,
      'startTime': instance.startTime.toIso8601String(),
      'userID': instance.userID,
    };
