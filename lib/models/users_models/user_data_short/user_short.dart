import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_short.freezed.dart';
part 'user_short.g.dart';

@freezed
class UserDataShort with _$UserDataShort {
  const factory UserDataShort({
    required String id,
    required String userName,
  }) = _UserDataShort;
  const UserDataShort._();
  factory UserDataShort.fromJson(Map<String, dynamic> json) => _$UserDataShortFromJson(json);
}
