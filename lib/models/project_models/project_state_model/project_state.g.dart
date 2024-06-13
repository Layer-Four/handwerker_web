// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectStateImpl _$$ProjectStateImplFromJson(Map<String, dynamic> json) =>
    _$ProjectStateImpl(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String?,
      editedAt: json['editedAt'] == null
          ? null
          : DateTime.parse(json['editedAt'] as String),
      editedBy: json['editedBy'] as String?,
      id: (json['id'] as num?)?.toInt(),
      mandantID: (json['mandantID'] as num?)?.toInt(),
      mandant: json['mandant'] as String?,
      projects: json['projects'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$$ProjectStateImplToJson(_$ProjectStateImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'createdBy': instance.createdBy,
      'editedAt': instance.editedAt?.toIso8601String(),
      'editedBy': instance.editedBy,
      'id': instance.id,
      'mandantID': instance.mandantID,
      'mandant': instance.mandant,
      'projects': instance.projects,
      'value': instance.value,
    };
