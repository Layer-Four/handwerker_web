// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consumable_vm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConsumableVM _$ConsumableVMFromJson(Map<String, dynamic> json) {
  return _ConsumableVM.fromJson(json);
}

/// @nodoc
mixin _$ConsumableVM {
  int get amount => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  Unit get unit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConsumableVMCopyWith<ConsumableVM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsumableVMCopyWith<$Res> {
  factory $ConsumableVMCopyWith(
          ConsumableVM value, $Res Function(ConsumableVM) then) =
      _$ConsumableVMCopyWithImpl<$Res, ConsumableVM>;
  @useResult
  $Res call({int amount, int? id, String name, double price, Unit unit});

  $UnitCopyWith<$Res> get unit;
}

/// @nodoc
class _$ConsumableVMCopyWithImpl<$Res, $Val extends ConsumableVM>
    implements $ConsumableVMCopyWith<$Res> {
  _$ConsumableVMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? id = freezed,
    Object? name = null,
    Object? price = null,
    Object? unit = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as Unit,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UnitCopyWith<$Res> get unit {
    return $UnitCopyWith<$Res>(_value.unit, (value) {
      return _then(_value.copyWith(unit: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConsumableVMImplCopyWith<$Res>
    implements $ConsumableVMCopyWith<$Res> {
  factory _$$ConsumableVMImplCopyWith(
          _$ConsumableVMImpl value, $Res Function(_$ConsumableVMImpl) then) =
      __$$ConsumableVMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int amount, int? id, String name, double price, Unit unit});

  @override
  $UnitCopyWith<$Res> get unit;
}

/// @nodoc
class __$$ConsumableVMImplCopyWithImpl<$Res>
    extends _$ConsumableVMCopyWithImpl<$Res, _$ConsumableVMImpl>
    implements _$$ConsumableVMImplCopyWith<$Res> {
  __$$ConsumableVMImplCopyWithImpl(
      _$ConsumableVMImpl _value, $Res Function(_$ConsumableVMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? id = freezed,
    Object? name = null,
    Object? price = null,
    Object? unit = null,
  }) {
    return _then(_$ConsumableVMImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as Unit,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsumableVMImpl extends _ConsumableVM {
  const _$ConsumableVMImpl(
      {required this.amount,
      this.id,
      required this.name,
      required this.price,
      required this.unit})
      : super._();

  factory _$ConsumableVMImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsumableVMImplFromJson(json);

  @override
  final int amount;
  @override
  final int? id;
  @override
  final String name;
  @override
  final double price;
  @override
  final Unit unit;

  @override
  String toString() {
    return 'ConsumableVM(amount: $amount, id: $id, name: $name, price: $price, unit: $unit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsumableVMImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount, id, name, price, unit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsumableVMImplCopyWith<_$ConsumableVMImpl> get copyWith =>
      __$$ConsumableVMImplCopyWithImpl<_$ConsumableVMImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsumableVMImplToJson(
      this,
    );
  }
}

abstract class _ConsumableVM extends ConsumableVM {
  const factory _ConsumableVM(
      {required final int amount,
      final int? id,
      required final String name,
      required final double price,
      required final Unit unit}) = _$ConsumableVMImpl;
  const _ConsumableVM._() : super._();

  factory _ConsumableVM.fromJson(Map<String, dynamic> json) =
      _$ConsumableVMImpl.fromJson;

  @override
  int get amount;
  @override
  int? get id;
  @override
  String get name;
  @override
  double get price;
  @override
  Unit get unit;
  @override
  @JsonKey(ignore: true)
  _$$ConsumableVMImplCopyWith<_$ConsumableVMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
