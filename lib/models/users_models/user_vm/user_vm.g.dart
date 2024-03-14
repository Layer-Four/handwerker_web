// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UsersImpl _$$UsersImplFromJson(Map<String, dynamic> json) => _$UsersImpl(
      userID: json['userID'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      token: json['token'] as String?,
      userRole: json['userRole'] as String? ?? 'worker',
    );

Map<String, dynamic> _$$UsersImplToJson(_$UsersImpl instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'token': instance.token,
      'userRole': instance.userRole,
    };
