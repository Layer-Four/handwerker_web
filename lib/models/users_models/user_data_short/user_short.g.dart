// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_short.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataShortImpl _$$UserDataShortImplFromJson(Map<String, dynamic> json) =>
    _$UserDataShortImpl(
      id: json['Id'] as String,
      userName: json['UserName'] as String,
      roles: (json['Roles'] as List<dynamic>?)
              ?.map((e) => UserRole.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserDataShortImplToJson(_$UserDataShortImpl instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'UserName': instance.userName,
      'Roles': instance.roles,
    };
