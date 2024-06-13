// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerCredentialDMImpl _$$CustomerCredentialDMImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerCredentialDMImpl(
      contactPerson: json['contactPerson'] as String,
      customerNumber: json['customerNumber'] as String?,
      customerCity: json['customerCity'] as String?,
      customerStreet: json['customerStreet'] as String?,
      customerStreetNr: json['customerStreetNr'] as String?,
      customerZipcode: json['customerZipcode'] as String?,
      customerEmail: json['customerEmail'] as String?,
      customerPhone: json['customerPhone'] as String?,
    );

Map<String, dynamic> _$$CustomerCredentialDMImplToJson(
        _$CustomerCredentialDMImpl instance) =>
    <String, dynamic>{
      'contactPerson': instance.contactPerson,
      'customerNumber': instance.customerNumber,
      'customerCity': instance.customerCity,
      'customerStreet': instance.customerStreet,
      'customerStreetNr': instance.customerStreetNr,
      'customerZipcode': instance.customerZipcode,
      'customerEmail': instance.customerEmail,
      'customerPhone': instance.customerPhone,
    };
