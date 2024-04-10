// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserVMImpl _$$UserVMImplFromJson(Map<String, dynamic> json) => _$UserVMImpl(
      userID: json['userID'] as String? ?? '',
      userToken: json['userToken'] as String? ?? '',
      username: json['username'] as String? ?? '',
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      hiringDate: json['hiringDate'] == null
          ? null
          : DateTime.parse(json['hiringDate'] as String),
      cancellationDate: json['cancellationDate'] == null
          ? null
          : DateTime.parse(json['cancellationDate'] as String),
      email: json['email'] as String?,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      address: json['address'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$$UserVMImplToJson(_$UserVMImpl instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'userToken': instance.userToken,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'hiringDate': instance.hiringDate?.toIso8601String(),
      'cancellationDate': instance.cancellationDate?.toIso8601String(),
      'email': instance.email,
      'profilePictureUrl': instance.profilePictureUrl,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
    };
