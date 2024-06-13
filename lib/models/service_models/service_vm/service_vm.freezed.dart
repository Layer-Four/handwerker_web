// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_vm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServiceVM _$ServiceVMFromJson(Map<String, dynamic> json) {
  return _ServiceVM.fromJson(json);
}

/// @nodoc
mixin _$ServiceVM {
  String get name => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  double get hourlyRate => throw _privateConstructorUsedError;
  int? get serviceAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceVMCopyWith<ServiceVM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceVMCopyWith<$Res> {
  factory $ServiceVMCopyWith(ServiceVM value, $Res Function(ServiceVM) then) =
      _$ServiceVMCopyWithImpl<$Res, ServiceVM>;
  @useResult
  $Res call({String name, int? id, double hourlyRate, int? serviceAmount});
}

/// @nodoc
class _$ServiceVMCopyWithImpl<$Res, $Val extends ServiceVM>
    implements $ServiceVMCopyWith<$Res> {
  _$ServiceVMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = freezed,
    Object? hourlyRate = null,
    Object? serviceAmount = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      hourlyRate: null == hourlyRate
          ? _value.hourlyRate
          : hourlyRate // ignore: cast_nullable_to_non_nullable
              as double,
      serviceAmount: freezed == serviceAmount
          ? _value.serviceAmount
          : serviceAmount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceVMImplCopyWith<$Res>
    implements $ServiceVMCopyWith<$Res> {
  factory _$$ServiceVMImplCopyWith(
          _$ServiceVMImpl value, $Res Function(_$ServiceVMImpl) then) =
      __$$ServiceVMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int? id, double hourlyRate, int? serviceAmount});
}

/// @nodoc
class __$$ServiceVMImplCopyWithImpl<$Res>
    extends _$ServiceVMCopyWithImpl<$Res, _$ServiceVMImpl>
    implements _$$ServiceVMImplCopyWith<$Res> {
  __$$ServiceVMImplCopyWithImpl(
      _$ServiceVMImpl _value, $Res Function(_$ServiceVMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = freezed,
    Object? hourlyRate = null,
    Object? serviceAmount = freezed,
  }) {
    return _then(_$ServiceVMImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      hourlyRate: null == hourlyRate
          ? _value.hourlyRate
          : hourlyRate // ignore: cast_nullable_to_non_nullable
              as double,
      serviceAmount: freezed == serviceAmount
          ? _value.serviceAmount
          : serviceAmount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceVMImpl implements _ServiceVM {
  const _$ServiceVMImpl(
      {required this.name,
      this.id,
      required this.hourlyRate,
      this.serviceAmount});

  factory _$ServiceVMImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceVMImplFromJson(json);

  @override
  final String name;
  @override
  final int? id;
  @override
  final double hourlyRate;
  @override
  final int? serviceAmount;

  @override
  String toString() {
    return 'ServiceVM(name: $name, id: $id, hourlyRate: $hourlyRate, serviceAmount: $serviceAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceVMImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hourlyRate, hourlyRate) ||
                other.hourlyRate == hourlyRate) &&
            (identical(other.serviceAmount, serviceAmount) ||
                other.serviceAmount == serviceAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, id, hourlyRate, serviceAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceVMImplCopyWith<_$ServiceVMImpl> get copyWith =>
      __$$ServiceVMImplCopyWithImpl<_$ServiceVMImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceVMImplToJson(
      this,
    );
  }
}

abstract class _ServiceVM implements ServiceVM {
  const factory _ServiceVM(
      {required final String name,
      final int? id,
      required final double hourlyRate,
      final int? serviceAmount}) = _$ServiceVMImpl;

  factory _ServiceVM.fromJson(Map<String, dynamic> json) =
      _$ServiceVMImpl.fromJson;

  @override
  String get name;
  @override
  int? get id;
  @override
  double get hourlyRate;
  @override
  int? get serviceAmount;
  @override
  @JsonKey(ignore: true)
  _$$ServiceVMImplCopyWith<_$ServiceVMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
