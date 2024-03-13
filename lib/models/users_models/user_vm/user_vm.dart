import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_vm.freezed.dart';
part 'user_vm.g.dart';

@freezed
class Users with _$Users {
  const factory Users() = _Users;
  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
}
