// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumableVMImpl _$$ConsumableVMImplFromJson(Map<String, dynamic> json) =>
    _$ConsumableVMImpl(
      amount: (json['amount'] as num).toDouble(),
      id: json['id'] as String?,
      name: json['name'] as String,
      netPrice: (json['netPrice'] as num).toDouble(),
      grossPrice: (json['grossPrice'] as num?)?.toDouble(),
      vat: (json['vat'] as num?)?.toDouble(),
      unit: json['unit'] == null
          ? null
          : Unit.fromJson(json['unit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ConsumableVMImplToJson(_$ConsumableVMImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'id': instance.id,
      'name': instance.name,
      'netPrice': instance.netPrice,
      'grossPrice': instance.grossPrice,
      'vat': instance.vat,
      'unit': instance.unit,
    };
