// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_report_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectRepotsDMImpl _$$ProjectRepotsDMImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectRepotsDMImpl(
      consumables: (json['consumables'] as List<dynamic>?)
              ?.map(
                  (e) => ProjectConsumable.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      projectID: (json['projectID'] as num?)?.toInt(),
      dateOfStart: json['dateOfStart'] == null
          ? null
          : DateTime.parse(json['dateOfStart'] as String),
      dateOfTermination: json['dateOfTermination'] == null
          ? null
          : DateTime.parse(json['dateOfTermination'] as String),
      projectDescription: json['projectDescription'] as String?,
      projectName: json['projectName'] as String?,
      projectRevenue: (json['projectRevenue'] as num?)?.toDouble(),
      projectState: json['projectState'] == null
          ? null
          : ProjectInfoState.fromJson(
              json['projectState'] as Map<String, dynamic>),
      reportsList: (json['reportsList'] as List<dynamic>?)
              ?.map((e) => ProjectTimeEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      serviceList: (json['serviceList'] as List<dynamic>?)
              ?.map((e) => ServiceProject.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ProjectRepotsDMImplToJson(
        _$ProjectRepotsDMImpl instance) =>
    <String, dynamic>{
      'consumables': instance.consumables,
      'projectID': instance.projectID,
      'dateOfStart': instance.dateOfStart?.toIso8601String(),
      'dateOfTermination': instance.dateOfTermination?.toIso8601String(),
      'projectDescription': instance.projectDescription,
      'projectName': instance.projectName,
      'projectRevenue': instance.projectRevenue,
      'projectState': instance.projectState,
      'reportsList': instance.reportsList,
      'serviceList': instance.serviceList,
    };
