// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_short_dm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomerShortDM _$CustomerShortDMFromJson(Map<String, dynamic> json) {
  return _CustomerShortDM.fromJson(json);
}

/// @nodoc
mixin _$CustomerShortDM {
  int get id => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerShortDMCopyWith<CustomerShortDM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerShortDMCopyWith<$Res> {
  factory $CustomerShortDMCopyWith(
          CustomerShortDM value, $Res Function(CustomerShortDM) then) =
      _$CustomerShortDMCopyWithImpl<$Res, CustomerShortDM>;
  @useResult
  $Res call({int id, String companyName});
}

/// @nodoc
class _$CustomerShortDMCopyWithImpl<$Res, $Val extends CustomerShortDM>
    implements $CustomerShortDMCopyWith<$Res> {
  _$CustomerShortDMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyName = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerShortDMImplCopyWith<$Res>
    implements $CustomerShortDMCopyWith<$Res> {
  factory _$$CustomerShortDMImplCopyWith(_$CustomerShortDMImpl value,
          $Res Function(_$CustomerShortDMImpl) then) =
      __$$CustomerShortDMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String companyName});
}

/// @nodoc
class __$$CustomerShortDMImplCopyWithImpl<$Res>
    extends _$CustomerShortDMCopyWithImpl<$Res, _$CustomerShortDMImpl>
    implements _$$CustomerShortDMImplCopyWith<$Res> {
  __$$CustomerShortDMImplCopyWithImpl(
      _$CustomerShortDMImpl _value, $Res Function(_$CustomerShortDMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? companyName = null,
  }) {
    return _then(_$CustomerShortDMImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerShortDMImpl implements _CustomerShortDM {
  _$CustomerShortDMImpl({required this.id, required this.companyName});

  factory _$CustomerShortDMImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerShortDMImplFromJson(json);

  @override
  final int id;
  @override
  final String companyName;

  @override
  String toString() {
    return 'CustomerShortDM(id: $id, companyName: $companyName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerShortDMImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, companyName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerShortDMImplCopyWith<_$CustomerShortDMImpl> get copyWith =>
      __$$CustomerShortDMImplCopyWithImpl<_$CustomerShortDMImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerShortDMImplToJson(
      this,
    );
  }
}

abstract class _CustomerShortDM implements CustomerShortDM {
  factory _CustomerShortDM(
      {required final int id,
      required final String companyName}) = _$CustomerShortDMImpl;

  factory _CustomerShortDM.fromJson(Map<String, dynamic> json) =
      _$CustomerShortDMImpl.fromJson;

  @override
  int get id;
  @override
  String get companyName;
  @override
  @JsonKey(ignore: true)
  _$$CustomerShortDMImplCopyWith<_$CustomerShortDMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
