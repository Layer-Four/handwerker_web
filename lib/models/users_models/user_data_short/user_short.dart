// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../user_role/user_role.dart';
part 'user_short.freezed.dart';
part 'user_short.g.dart';

@freezed
class UserDataShort with _$UserDataShort {
  const factory UserDataShort({
    @JsonKey(name: 'Id') required String id,
    @JsonKey(name: 'UserName') required String userName,
    @Default([]) @JsonKey(name: 'Roles') List<UserRole> roles,
  }) = _UserDataShort;
  const UserDataShort._();

  factory UserDataShort.fromJson(Map<String, dynamic> json) => _$UserDataShortFromJson(json);
}
