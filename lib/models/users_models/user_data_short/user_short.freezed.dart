// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_short.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserDataShort _$UserDataShortFromJson(Map<String, dynamic> json) {
  return _UserDataShort.fromJson(json);
}

/// @nodoc
mixin _$UserDataShort {
  String get id => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  List<UserRole> get roles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDataShortCopyWith<UserDataShort> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataShortCopyWith<$Res> {
  factory $UserDataShortCopyWith(
          UserDataShort value, $Res Function(UserDataShort) then) =
      _$UserDataShortCopyWithImpl<$Res, UserDataShort>;
  @useResult
  $Res call({String id, String userName, List<UserRole> roles});
}

/// @nodoc
class _$UserDataShortCopyWithImpl<$Res, $Val extends UserDataShort>
    implements $UserDataShortCopyWith<$Res> {
  _$UserDataShortCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userName = null,
    Object? roles = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      roles: null == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<UserRole>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserDataShortImplCopyWith<$Res>
    implements $UserDataShortCopyWith<$Res> {
  factory _$$UserDataShortImplCopyWith(
          _$UserDataShortImpl value, $Res Function(_$UserDataShortImpl) then) =
      __$$UserDataShortImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String userName, List<UserRole> roles});
}

/// @nodoc
class __$$UserDataShortImplCopyWithImpl<$Res>
    extends _$UserDataShortCopyWithImpl<$Res, _$UserDataShortImpl>
    implements _$$UserDataShortImplCopyWith<$Res> {
  __$$UserDataShortImplCopyWithImpl(
      _$UserDataShortImpl _value, $Res Function(_$UserDataShortImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userName = null,
    Object? roles = null,
  }) {
    return _then(_$UserDataShortImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<UserRole>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDataShortImpl extends _UserDataShort {
  const _$UserDataShortImpl(
      {required this.id,
      required this.userName,
      final List<UserRole> roles = const []})
      : _roles = roles,
        super._();

  factory _$UserDataShortImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDataShortImplFromJson(json);

  @override
  final String id;
  @override
  final String userName;
  final List<UserRole> _roles;
  @override
  @JsonKey()
  List<UserRole> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  String toString() {
    return 'UserDataShort(id: $id, userName: $userName, roles: $roles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataShortImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            const DeepCollectionEquality().equals(other._roles, _roles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userName, const DeepCollectionEquality().hash(_roles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataShortImplCopyWith<_$UserDataShortImpl> get copyWith =>
      __$$UserDataShortImplCopyWithImpl<_$UserDataShortImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDataShortImplToJson(
      this,
    );
  }
}

abstract class _UserDataShort extends UserDataShort {
  const factory _UserDataShort(
      {required final String id,
      required final String userName,
      final List<UserRole> roles}) = _$UserDataShortImpl;
  const _UserDataShort._() : super._();

  factory _UserDataShort.fromJson(Map<String, dynamic> json) =
      _$UserDataShortImpl.fromJson;

  @override
  String get id;
  @override
  String get userName;
  @override
  List<UserRole> get roles;
  @override
  @JsonKey(ignore: true)
  _$$UserDataShortImplCopyWith<_$UserDataShortImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
