// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_report_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectRepotsDMImpl _$$ProjectRepotsDMImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectRepotsDMImpl(
      customerName: json['customerName'] as String,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => ConsumableVM.fromJson(e as Map<String, dynamic>))
          .toList(),
      projectID: (json['projectID'] as num).toInt(),
      projectName: json['projectName'] as String,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => ServiceVM.fromJson(e as Map<String, dynamic>))
          .toList(),
      state: json['state'] as String?,
      timeRange: json['timeRange'] as String?,
      turnover: (json['turnover'] as num).toInt(),
    );

Map<String, dynamic> _$$ProjectRepotsDMImplToJson(
        _$ProjectRepotsDMImpl instance) =>
    <String, dynamic>{
      'customerName': instance.customerName,
      'materials': instance.materials,
      'projectID': instance.projectID,
      'projectName': instance.projectName,
      'services': instance.services,
      'state': instance.state,
      'timeRange': instance.timeRange,
      'turnover': instance.turnover,
    };
