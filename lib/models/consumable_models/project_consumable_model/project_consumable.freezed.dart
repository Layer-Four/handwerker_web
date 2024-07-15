// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_consumable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectConsumable _$ProjectConsumableFromJson(Map<String, dynamic> json) {
  return _ProjectConsumable.fromJson(json);
}

/// @nodoc
mixin _$ProjectConsumable {
  String get consumableName =>
      throw _privateConstructorUsedError; // TODO: Update when Consumable List in CustomerProjectReoports get amount
  int? get consumableAmount => throw _privateConstructorUsedError;
  double get consumablePrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectConsumableCopyWith<ProjectConsumable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectConsumableCopyWith<$Res> {
  factory $ProjectConsumableCopyWith(
          ProjectConsumable value, $Res Function(ProjectConsumable) then) =
      _$ProjectConsumableCopyWithImpl<$Res, ProjectConsumable>;
  @useResult
  $Res call(
      {String consumableName, int? consumableAmount, double consumablePrice});
}

/// @nodoc
class _$ProjectConsumableCopyWithImpl<$Res, $Val extends ProjectConsumable>
    implements $ProjectConsumableCopyWith<$Res> {
  _$ProjectConsumableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consumableName = null,
    Object? consumableAmount = freezed,
    Object? consumablePrice = null,
  }) {
    return _then(_value.copyWith(
      consumableName: null == consumableName
          ? _value.consumableName
          : consumableName // ignore: cast_nullable_to_non_nullable
              as String,
      consumableAmount: freezed == consumableAmount
          ? _value.consumableAmount
          : consumableAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      consumablePrice: null == consumablePrice
          ? _value.consumablePrice
          : consumablePrice // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectConsumableImplCopyWith<$Res>
    implements $ProjectConsumableCopyWith<$Res> {
  factory _$$ProjectConsumableImplCopyWith(_$ProjectConsumableImpl value,
          $Res Function(_$ProjectConsumableImpl) then) =
      __$$ProjectConsumableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String consumableName, int? consumableAmount, double consumablePrice});
}

/// @nodoc
class __$$ProjectConsumableImplCopyWithImpl<$Res>
    extends _$ProjectConsumableCopyWithImpl<$Res, _$ProjectConsumableImpl>
    implements _$$ProjectConsumableImplCopyWith<$Res> {
  __$$ProjectConsumableImplCopyWithImpl(_$ProjectConsumableImpl _value,
      $Res Function(_$ProjectConsumableImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consumableName = null,
    Object? consumableAmount = freezed,
    Object? consumablePrice = null,
  }) {
    return _then(_$ProjectConsumableImpl(
      consumableName: null == consumableName
          ? _value.consumableName
          : consumableName // ignore: cast_nullable_to_non_nullable
              as String,
      consumableAmount: freezed == consumableAmount
          ? _value.consumableAmount
          : consumableAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      consumablePrice: null == consumablePrice
          ? _value.consumablePrice
          : consumablePrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectConsumableImpl implements _ProjectConsumable {
  const _$ProjectConsumableImpl(
      {required this.consumableName,
      this.consumableAmount,
      required this.consumablePrice});

  factory _$ProjectConsumableImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectConsumableImplFromJson(json);

  @override
  final String consumableName;
// TODO: Update when Consumable List in CustomerProjectReoports get amount
  @override
  final int? consumableAmount;
  @override
  final double consumablePrice;

  @override
  String toString() {
    return 'ProjectConsumable(consumableName: $consumableName, consumableAmount: $consumableAmount, consumablePrice: $consumablePrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectConsumableImpl &&
            (identical(other.consumableName, consumableName) ||
                other.consumableName == consumableName) &&
            (identical(other.consumableAmount, consumableAmount) ||
                other.consumableAmount == consumableAmount) &&
            (identical(other.consumablePrice, consumablePrice) ||
                other.consumablePrice == consumablePrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, consumableName, consumableAmount, consumablePrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectConsumableImplCopyWith<_$ProjectConsumableImpl> get copyWith =>
      __$$ProjectConsumableImplCopyWithImpl<_$ProjectConsumableImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectConsumableImplToJson(
      this,
    );
  }
}

abstract class _ProjectConsumable implements ProjectConsumable {
  const factory _ProjectConsumable(
      {required final String consumableName,
      final int? consumableAmount,
      required final double consumablePrice}) = _$ProjectConsumableImpl;

  factory _ProjectConsumable.fromJson(Map<String, dynamic> json) =
      _$ProjectConsumableImpl.fromJson;

  @override
  String get consumableName;
  @override // TODO: Update when Consumable List in CustomerProjectReoports get amount
  int? get consumableAmount;
  @override
  double get consumablePrice;
  @override
  @JsonKey(ignore: true)
  _$$ProjectConsumableImplCopyWith<_$ProjectConsumableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
