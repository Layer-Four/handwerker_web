// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_projects_report_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerProjectsReportDMImpl _$$CustomerProjectsReportDMImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerProjectsReportDMImpl(
      customerCredentials: CustomerCredentialDM.fromJson(
          json['customerCredentials'] as Map<String, dynamic>),
      customerName: json['customerName'] as String?,
      customerRevenue: (json['customerRevenue'] as num?)?.toDouble(),
      projectsList: (json['projectsList'] as List<dynamic>?)
              ?.map((e) => ProjectRepotsDM.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CustomerProjectsReportDMImplToJson(
        _$CustomerProjectsReportDMImpl instance) =>
    <String, dynamic>{
      'customerCredentials': instance.customerCredentials,
      'customerName': instance.customerName,
      'customerRevenue': instance.customerRevenue,
      'projectsList': instance.projectsList,
    };
