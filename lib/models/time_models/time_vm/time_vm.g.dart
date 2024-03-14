// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeEntryVMImpl _$$TimeEntryVMImplFromJson(Map<String, dynamic> json) =>
    _$TimeEntryVMImpl(
      timeEntryID: json['timeEntryID'] as String? ?? '',
      projectID: json['projectID'] as int?,
      serviceID: json['serviceID'] as int?,
      duration: json['duration'] as int?,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      description: json['description'] as String?,
      useForColor: json['useForColor'] as String?,
    );

Map<String, dynamic> _$$TimeEntryVMImplToJson(_$TimeEntryVMImpl instance) =>
    <String, dynamic>{
      'timeEntryID': instance.timeEntryID,
      'projectID': instance.projectID,
      'serviceID': instance.serviceID,
      'duration': instance.duration,
      'title': instance.title,
      'date': instance.date.toIso8601String(),
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'description': instance.description,
      'useForColor': instance.useForColor,
    };
