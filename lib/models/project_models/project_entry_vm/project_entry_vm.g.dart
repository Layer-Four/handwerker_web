// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_entry_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectEntryVMImpl _$$ProjectEntryVMImplFromJson(Map<String, dynamic> json) =>
    _$ProjectEntryVMImpl(
      title: json['title'] as String,
      start: DateTime.parse(json['start'] as String),
      terminationDate: DateTime.parse(json['terminationDate'] as String),
      state: $enumDecodeNullable(_$ProjectStateEnumMap, json['state']) ??
          ProjectState.planning,
      description: json['description'] as String?,
      id: (json['id'] as num?)?.toInt(),
      customer: json['customer'] == null
          ? null
          : CustomerShortDM.fromJson(json['customer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProjectEntryVMImplToJson(
        _$ProjectEntryVMImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'start': instance.start.toIso8601String(),
      'terminationDate': instance.terminationDate.toIso8601String(),
      'state': _$ProjectStateEnumMap[instance.state]!,
      'description': instance.description,
      'id': instance.id,
      'customer': instance.customer,
    };

const _$ProjectStateEnumMap = {
  ProjectState.finished: 'finished',
  ProjectState.start: 'start',
  ProjectState.paused: 'paused',
  ProjectState.planning: 'planning',
};
