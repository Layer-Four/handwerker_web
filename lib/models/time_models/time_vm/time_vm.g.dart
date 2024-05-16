// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeVMAdapterImpl _$$TimeVMAdapterImplFromJson(Map<String, dynamic> json) =>
    _$TimeVMAdapterImpl(
      id: (json['id'] as num).toInt(),
      userId: json['userId'] as String,
      projectId: (json['projectId'] as num?)?.toInt(),
      serviceId: (json['serviceId'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
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
      useForColor: json['useForColor'] as String?,
    );

Map<String, dynamic> _$$TimeVMAdapterImplToJson(_$TimeVMAdapterImpl instance) =>
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
      'useForColor': instance.useForColor,
    };
