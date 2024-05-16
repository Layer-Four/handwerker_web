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
      projectID: (json['projectID'] as num?)?.toInt(),
      serviceID: (json['serviceID'] as num?)?.toInt(),
      startTime: DateTime.parse(json['startTime'] as String),
      userID: json['userID'] as String? ?? '',
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
      'projectID': instance.projectID,
      'serviceID': instance.serviceID,
      'startTime': instance.startTime.toIso8601String(),
      'userID': instance.userID,
    };
