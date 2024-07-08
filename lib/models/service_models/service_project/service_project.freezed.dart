// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServiceProject _$ServiceProjectFromJson(Map<String, dynamic> json) {
  return _ServiceProject.fromJson(json);
}

/// @nodoc
mixin _$ServiceProject {
  String get serviceName => throw _privateConstructorUsedError;
  int get serviceAmount => throw _privateConstructorUsedError;
  double get servicePrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceProjectCopyWith<ServiceProject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceProjectCopyWith<$Res> {
  factory $ServiceProjectCopyWith(
          ServiceProject value, $Res Function(ServiceProject) then) =
      _$ServiceProjectCopyWithImpl<$Res, ServiceProject>;
  @useResult
  $Res call({String serviceName, int serviceAmount, double servicePrice});
}

/// @nodoc
class _$ServiceProjectCopyWithImpl<$Res, $Val extends ServiceProject>
    implements $ServiceProjectCopyWith<$Res> {
  _$ServiceProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceName = null,
    Object? serviceAmount = null,
    Object? servicePrice = null,
  }) {
    return _then(_value.copyWith(
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceAmount: null == serviceAmount
          ? _value.serviceAmount
          : serviceAmount // ignore: cast_nullable_to_non_nullable
              as int,
      servicePrice: null == servicePrice
          ? _value.servicePrice
          : servicePrice // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceProjectImplCopyWith<$Res>
    implements $ServiceProjectCopyWith<$Res> {
  factory _$$ServiceProjectImplCopyWith(_$ServiceProjectImpl value,
          $Res Function(_$ServiceProjectImpl) then) =
      __$$ServiceProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String serviceName, int serviceAmount, double servicePrice});
}

/// @nodoc
class __$$ServiceProjectImplCopyWithImpl<$Res>
    extends _$ServiceProjectCopyWithImpl<$Res, _$ServiceProjectImpl>
    implements _$$ServiceProjectImplCopyWith<$Res> {
  __$$ServiceProjectImplCopyWithImpl(
      _$ServiceProjectImpl _value, $Res Function(_$ServiceProjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceName = null,
    Object? serviceAmount = null,
    Object? servicePrice = null,
  }) {
    return _then(_$ServiceProjectImpl(
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceAmount: null == serviceAmount
          ? _value.serviceAmount
          : serviceAmount // ignore: cast_nullable_to_non_nullable
              as int,
      servicePrice: null == servicePrice
          ? _value.servicePrice
          : servicePrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceProjectImpl implements _ServiceProject {
  _$ServiceProjectImpl(
      {required this.serviceName,
      required this.serviceAmount,
      required this.servicePrice});

  factory _$ServiceProjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceProjectImplFromJson(json);

  @override
  final String serviceName;
  @override
  final int serviceAmount;
  @override
  final double servicePrice;

  @override
  String toString() {
    return 'ServiceProject(serviceName: $serviceName, serviceAmount: $serviceAmount, servicePrice: $servicePrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceProjectImpl &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.serviceAmount, serviceAmount) ||
                other.serviceAmount == serviceAmount) &&
            (identical(other.servicePrice, servicePrice) ||
                other.servicePrice == servicePrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, serviceName, serviceAmount, servicePrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceProjectImplCopyWith<_$ServiceProjectImpl> get copyWith =>
      __$$ServiceProjectImplCopyWithImpl<_$ServiceProjectImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceProjectImplToJson(
      this,
    );
  }
}

abstract class _ServiceProject implements ServiceProject {
  factory _ServiceProject(
      {required final String serviceName,
      required final int serviceAmount,
      required final double servicePrice}) = _$ServiceProjectImpl;

  factory _ServiceProject.fromJson(Map<String, dynamic> json) =
      _$ServiceProjectImpl.fromJson;

  @override
  String get serviceName;
  @override
  int get serviceAmount;
  @override
  double get servicePrice;
  @override
  @JsonKey(ignore: true)
  _$$ServiceProjectImplCopyWith<_$ServiceProjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
