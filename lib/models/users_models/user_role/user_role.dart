import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_role.g.dart';
part 'user_role.freezed.dart';

@freezed
class UserRole with _$UserRole {
  const UserRole._();
  const factory UserRole({
    required String id,
    required String name,
    required String normalizedName,
  }) = _UserRole;

  factory UserRole.fromJson(Map<String, dynamic> json) => _$UserRoleFromJson(json);
}
