// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_short_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectShortVMImpl _$$ProjectShortVMImplFromJson(Map<String, dynamic> json) =>
    _$ProjectShortVMImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      customerId: (json['customerId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProjectShortVMImplToJson(
        _$ProjectShortVMImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'customerId': instance.customerId,
    };
