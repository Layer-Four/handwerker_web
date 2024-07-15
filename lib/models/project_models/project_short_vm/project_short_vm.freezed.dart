// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_short_vm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectShortVM _$ProjectShortVMFromJson(Map<String, dynamic> json) {
  return _ProjectShortVM.fromJson(json);
}

/// @nodoc
mixin _$ProjectShortVM {
  int? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  int? get customerId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectShortVMCopyWith<ProjectShortVM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectShortVMCopyWith<$Res> {
  factory $ProjectShortVMCopyWith(
          ProjectShortVM value, $Res Function(ProjectShortVM) then) =
      _$ProjectShortVMCopyWithImpl<$Res, ProjectShortVM>;
  @useResult
  $Res call({int? id, String? title, int? customerId});
}

/// @nodoc
class _$ProjectShortVMCopyWithImpl<$Res, $Val extends ProjectShortVM>
    implements $ProjectShortVMCopyWith<$Res> {
  _$ProjectShortVMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? customerId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectShortVMImplCopyWith<$Res>
    implements $ProjectShortVMCopyWith<$Res> {
  factory _$$ProjectShortVMImplCopyWith(_$ProjectShortVMImpl value,
          $Res Function(_$ProjectShortVMImpl) then) =
      __$$ProjectShortVMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? title, int? customerId});
}

/// @nodoc
class __$$ProjectShortVMImplCopyWithImpl<$Res>
    extends _$ProjectShortVMCopyWithImpl<$Res, _$ProjectShortVMImpl>
    implements _$$ProjectShortVMImplCopyWith<$Res> {
  __$$ProjectShortVMImplCopyWithImpl(
      _$ProjectShortVMImpl _value, $Res Function(_$ProjectShortVMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? customerId = freezed,
  }) {
    return _then(_$ProjectShortVMImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectShortVMImpl implements _ProjectShortVM {
  const _$ProjectShortVMImpl({this.id, this.title, this.customerId});

  factory _$ProjectShortVMImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectShortVMImplFromJson(json);

  @override
  final int? id;
  @override
  final String? title;
  @override
  final int? customerId;

  @override
  String toString() {
    return 'ProjectShortVM(id: $id, title: $title, customerId: $customerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectShortVMImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, customerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectShortVMImplCopyWith<_$ProjectShortVMImpl> get copyWith =>
      __$$ProjectShortVMImplCopyWithImpl<_$ProjectShortVMImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectShortVMImplToJson(
      this,
    );
  }
}

abstract class _ProjectShortVM implements ProjectShortVM {
  const factory _ProjectShortVM(
      {final int? id,
      final String? title,
      final int? customerId}) = _$ProjectShortVMImpl;

  factory _ProjectShortVM.fromJson(Map<String, dynamic> json) =
      _$ProjectShortVMImpl.fromJson;

  @override
  int? get id;
  @override
  String? get title;
  @override
  int? get customerId;
  @override
  @JsonKey(ignore: true)
  _$$ProjectShortVMImplCopyWith<_$ProjectShortVMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
