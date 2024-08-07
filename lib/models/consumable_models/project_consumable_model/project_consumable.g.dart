// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_consumable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectConsumableImpl _$$ProjectConsumableImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectConsumableImpl(
      consumableName: json['consumableName'] as String,
      consumableAmount: (json['consumableAmount'] as num).toInt(),
      consumableNetPrice: (json['consumableNetPrice'] as num).toDouble(),
      consumableGrossPrice: (json['consumableGrossPrice'] as num?)?.toDouble(),
      consumableVAT: (json['consumableVAT'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ProjectConsumableImplToJson(
        _$ProjectConsumableImpl instance) =>
    <String, dynamic>{
      'consumableName': instance.consumableName,
      'consumableAmount': instance.consumableAmount,
      'consumableNetPrice': instance.consumableNetPrice,
      'consumableGrossPrice': instance.consumableGrossPrice,
      'consumableVAT': instance.consumableVAT,
    };
