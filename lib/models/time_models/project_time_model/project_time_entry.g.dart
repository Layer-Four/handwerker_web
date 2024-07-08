// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_time_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectTimeEntryImpl _$$ProjectTimeEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectTimeEntryImpl(
      startTimeDate: json['startTimeDate'] == null
          ? null
          : DateTime.parse(json['startTimeDate'] as String),
      workDescription: json['workDescription'] as String?,
      imagePathList: (json['imagePathList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ProjectTimeEntryImplToJson(
        _$ProjectTimeEntryImpl instance) =>
    <String, dynamic>{
      'startTimeDate': instance.startTimeDate?.toIso8601String(),
      'workDescription': instance.workDescription,
      'imagePathList': instance.imagePathList,
    };
