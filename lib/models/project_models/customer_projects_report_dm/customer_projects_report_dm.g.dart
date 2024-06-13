// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_projects_report_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerProjectsReportDMImpl _$$CustomerProjectsReportDMImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerProjectsReportDMImpl(
      customerName: json['customerName'] as String?,
      customerRevenue: (json['customerRevenue'] as num?)?.toDouble() ?? 0.0,
      customerCredentials: CustomerCredentialDM.fromJson(
          json['customerCredentials'] as Map<String, dynamic>),
      projectsList: (json['projectsList'] as List<dynamic>?)
              ?.map((e) => ProjectRepotsDM.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CustomerProjectsReportDMImplToJson(
        _$CustomerProjectsReportDMImpl instance) =>
    <String, dynamic>{
      'customerName': instance.customerName,
      'customerRevenue': instance.customerRevenue,
      'customerCredentials': instance.customerCredentials,
      'projectsList': instance.projectsList,
    };
