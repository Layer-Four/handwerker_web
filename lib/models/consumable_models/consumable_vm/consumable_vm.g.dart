// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumableVMImpl _$$ConsumableVMImplFromJson(Map<String, dynamic> json) =>
    _$ConsumableVMImpl(
      amount: (json['amount'] as num).toInt(),
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      unit: Unit.fromJson(json['unit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ConsumableVMImplToJson(_$ConsumableVMImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'unit': instance.unit,
    };
