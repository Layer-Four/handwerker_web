// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_overvew_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerOvervewDMImpl _$$CustomerOvervewDMImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerOvervewDMImpl(
      customerCredentials: CustomerCredentialDM.fromJson(
          json['customerCredentials'] as Map<String, dynamic>),
      customerID: (json['customerID'] as num?)?.toInt(),
      numOfProjects: (json['numOfProjects'] as num?)?.toInt() ?? 0,
      totalTimeTracked: (json['totalTimeTracked'] as num?)?.toInt() ?? 0,
      totalCostMaterial: (json['totalCostMaterial'] as num?)?.toDouble(),
      turnover: (json['turnover'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$CustomerOvervewDMImplToJson(
        _$CustomerOvervewDMImpl instance) =>
    <String, dynamic>{
      'customerCredentials': instance.customerCredentials,
      'customerID': instance.customerID,
      'numOfProjects': instance.numOfProjects,
      'totalTimeTracked': instance.totalTimeTracked,
      'totalCostMaterial': instance.totalCostMaterial,
      'turnover': instance.turnover,
    };
