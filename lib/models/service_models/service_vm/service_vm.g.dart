// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceVMImpl _$$ServiceVMImplFromJson(Map<String, dynamic> json) =>
    _$ServiceVMImpl(
      name: json['name'] as String,
      id: (json['id'] as num?)?.toInt(),
      hourlyRate: (json['hourlyRate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ServiceVMImplToJson(_$ServiceVMImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'hourlyRate': instance.hourlyRate,
    };
