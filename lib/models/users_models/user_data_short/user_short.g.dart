// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_short.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataShortImpl _$$UserDataShortImplFromJson(Map<String, dynamic> json) =>
    _$UserDataShortImpl(
      id: json['id'] as String,
      userName: json['userName'] as String,
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => UserRole.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserDataShortImplToJson(_$UserDataShortImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'roles': instance.roles,
    };
