import 'package:freezed_annotation/freezed_annotation.dart';

import '../user_role/user_role.dart';
part 'user_short.freezed.dart';
part 'user_short.g.dart';

@freezed
class UserDataShort with _$UserDataShort {
  const factory UserDataShort({
    required String id,
    required String userName,
    @Default([]) List<UserRole> roles,
  }) = _UserDataShort;
  const UserDataShort._();
  factory UserDataShort.fromJson(Map<String, dynamic> json) => _$UserDataShortFromJson(json);
}
