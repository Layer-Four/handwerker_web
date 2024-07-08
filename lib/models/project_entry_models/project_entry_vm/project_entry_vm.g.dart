// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_entry_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectEntryVMImpl _$$ProjectEntryVMImplFromJson(Map<String, dynamic> json) =>
    _$ProjectEntryVMImpl(
      title: json['title'] as String?,
      dateOfStart: json['dateOfStart'] as String?,
      dateOfTermination: json['dateOfTermination'] as String?,
      projectStatusId: (json['projectStatusId'] as num?)?.toInt(),
      customerId: (json['customerId'] as num?)?.toInt(),
      description: json['description'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProjectEntryVMImplToJson(
        _$ProjectEntryVMImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'dateOfStart': instance.dateOfStart,
      'dateOfTermination': instance.dateOfTermination,
      'projectStatusId': instance.projectStatusId,
      'customerId': instance.customerId,
      'description': instance.description,
      'id': instance.id,
    };
