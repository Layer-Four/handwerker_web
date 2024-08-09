// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumableDMImpl _$$ConsumableDMImplFromJson(Map<String, dynamic> json) =>
    _$ConsumableDMImpl(
      amount: (json['amount'] as num?)?.toDouble() ?? 1,
      id: (json['id'] as num?)?.toInt(),
      materialUnitID: (json['materialUnitID'] as num?)?.toInt(),
      name: json['name'] as String?,
      materialID: json['materialID'] as String?,
      netPrice: (json['netPrice'] as num?)?.toDouble(),
      grossPrice: (json['grossPrice'] as num?)?.toDouble(),
      vat: (json['vat'] as num?)?.toDouble(),
      materialUnitName: json['materialUnitName'] as String?,
    );

Map<String, dynamic> _$$ConsumableDMImplToJson(_$ConsumableDMImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'id': instance.id,
      'materialUnitID': instance.materialUnitID,
      'name': instance.name,
      'materialID': instance.materialID,
      'netPrice': instance.netPrice,
      'grossPrice': instance.grossPrice,
      'vat': instance.vat,
      'materialUnitName': instance.materialUnitName,
    };
