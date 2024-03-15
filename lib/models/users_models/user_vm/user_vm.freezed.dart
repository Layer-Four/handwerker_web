// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_vm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserVM _$UserVMFromJson(Map<String, dynamic> json) {
  return _UserVM.fromJson(json);
}

/// @nodoc
mixin _$UserVM {
  String get userID => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String get userRole => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserVMCopyWith<UserVM> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserVMCopyWith<$Res> {
  factory $UserVMCopyWith(UserVM value, $Res Function(UserVM) then) =
      _$UserVMCopyWithImpl<$Res, UserVM>;
  @useResult
  $Res call(
      {String userID,
      String? firstName,
      String? lastName,
      String? token,
      String userRole});
}

/// @nodoc
class _$UserVMCopyWithImpl<$Res, $Val extends UserVM>
    implements $UserVMCopyWith<$Res> {
  _$UserVMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userID = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? token = freezed,
    Object? userRole = null,
  }) {
    return _then(_value.copyWith(
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      userRole: null == userRole
          ? _value.userRole
          : userRole // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserVMImplCopyWith<$Res> implements $UserVMCopyWith<$Res> {
  factory _$$UserVMImplCopyWith(
          _$UserVMImpl value, $Res Function(_$UserVMImpl) then) =
      __$$UserVMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userID,
      String? firstName,
      String? lastName,
      String? token,
      String userRole});
}

/// @nodoc
class __$$UserVMImplCopyWithImpl<$Res>
    extends _$UserVMCopyWithImpl<$Res, _$UserVMImpl>
    implements _$$UserVMImplCopyWith<$Res> {
  __$$UserVMImplCopyWithImpl(
      _$UserVMImpl _value, $Res Function(_$UserVMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userID = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? token = freezed,
    Object? userRole = null,
  }) {
    return _then(_$UserVMImpl(
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      userRole: null == userRole
          ? _value.userRole
          : userRole // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserVMImpl extends _UserVM {
  const _$UserVMImpl(
      {required this.userID,
      this.firstName,
      this.lastName,
      this.token,
      this.userRole = 'worker'})
      : super._();

  factory _$UserVMImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserVMImplFromJson(json);

  @override
  final String userID;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? token;
  @override
  @JsonKey()
  final String userRole;

  @override
  String toString() {
    return 'UserVM(userID: $userID, firstName: $firstName, lastName: $lastName, token: $token, userRole: $userRole)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserVMImpl &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.userRole, userRole) ||
                other.userRole == userRole));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userID, firstName, lastName, token, userRole);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserVMImplCopyWith<_$UserVMImpl> get copyWith =>
      __$$UserVMImplCopyWithImpl<_$UserVMImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserVMImplToJson(
      this,
    );
  }
}

abstract class _UserVM extends UserVM {
  const factory _UserVM(
      {required final String userID,
      final String? firstName,
      final String? lastName,
      final String? token,
      final String userRole}) = _$UserVMImpl;
  const _UserVM._() : super._();

  factory _UserVM.fromJson(Map<String, dynamic> json) = _$UserVMImpl.fromJson;

  @override
  String get userID;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get token;
  @override
  String get userRole;
  @override
  @JsonKey(ignore: true)
  _$$UserVMImplCopyWith<_$UserVMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
