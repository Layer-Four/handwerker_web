// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectVMImpl _$$ProjectVMImplFromJson(Map<String, dynamic> json) =>
    _$ProjectVMImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      customerId: (json['customerId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProjectVMImplToJson(_$ProjectVMImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'customerId': instance.customerId,
    };
