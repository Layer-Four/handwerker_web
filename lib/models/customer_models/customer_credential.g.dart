// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerCredentialDMImpl _$$CustomerCredentialDMImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerCredentialDMImpl(
      contactName: json['contactName'] as String,
      customerCity: json['customerCity'] as String?,
      customerEmail: json['customerEmail'] as String?,
      customerNumber: json['customerNumber'] as String?,
      customerPhone: json['customerPhone'] as String?,
      customerStreet: json['customerStreet'] as String?,
      customerStreetNr: json['customerStreetNr'] as String?,
      customerZipcode: json['customerZipcode'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$$CustomerCredentialDMImplToJson(
        _$CustomerCredentialDMImpl instance) =>
    <String, dynamic>{
      'contactName': instance.contactName,
      'customerCity': instance.customerCity,
      'customerEmail': instance.customerEmail,
      'customerNumber': instance.customerNumber,
      'customerPhone': instance.customerPhone,
      'customerStreet': instance.customerStreet,
      'customerStreetNr': instance.customerStreetNr,
      'customerZipcode': instance.customerZipcode,
      'country': instance.country,
    };
