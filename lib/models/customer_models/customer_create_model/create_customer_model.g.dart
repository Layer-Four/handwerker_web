// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateCustomerDMImpl _$$CreateCustomerDMImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateCustomerDMImpl(
      id: (json['id'] as num?)?.toInt(),
      externalId: json['externalId'] as String?,
      companyName: json['companyName'] as String?,
      contactName: json['contactName'] as String?,
      contactPhone: json['contactPhone'] as String?,
      contactMail: json['contactMail'] as String?,
      street: json['street'] as String?,
      streetNr: json['streetNr'] as String?,
      zipcode: json['zipcode'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String? ?? 'Deutschland',
    );

Map<String, dynamic> _$$CreateCustomerDMImplToJson(
        _$CreateCustomerDMImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'companyName': instance.companyName,
      'contactName': instance.contactName,
      'contactPhone': instance.contactPhone,
      'contactMail': instance.contactMail,
      'street': instance.street,
      'streetNr': instance.streetNr,
      'zipcode': instance.zipcode,
      'city': instance.city,
      'country': instance.country,
    };
