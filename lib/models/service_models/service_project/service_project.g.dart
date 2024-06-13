// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceProjectImpl _$$ServiceProjectImplFromJson(Map<String, dynamic> json) =>
    _$ServiceProjectImpl(
      serviceName: json['serviceName'] as String,
      serviceAmount: (json['serviceAmount'] as num).toInt(),
      servicePrice: (json['servicePrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$ServiceProjectImplToJson(
        _$ServiceProjectImpl instance) =>
    <String, dynamic>{
      'serviceName': instance.serviceName,
      'serviceAmount': instance.serviceAmount,
      'servicePrice': instance.servicePrice,
    };
