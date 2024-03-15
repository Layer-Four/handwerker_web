import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_vm.freezed.dart';
part 'user_vm.g.dart';

@freezed
class UserVM with _$UserVM {
  const factory UserVM({
    required String userID,
    String? firstName,
    String? lastName,
    String? token,
    @Default('worker') String userRole,
  }) = _UserVM;
  factory UserVM.fromJson(Map<String, dynamic> json) => _$UserVMFromJson(json);
  const UserVM._();
}
