// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_vm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectVM _$ProjectVMFromJson(Map<String, dynamic> json) {
  return _ProjectVM.fromJson(json);
}

/// @nodoc
mixin _$ProjectVM {
  int get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  int? get customerId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectVMCopyWith<ProjectVM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectVMCopyWith<$Res> {
  factory $ProjectVMCopyWith(ProjectVM value, $Res Function(ProjectVM) then) =
      _$ProjectVMCopyWithImpl<$Res, ProjectVM>;
  @useResult
  $Res call({int id, String? title, int? customerId});
}

/// @nodoc
class _$ProjectVMCopyWithImpl<$Res, $Val extends ProjectVM>
    implements $ProjectVMCopyWith<$Res> {
  _$ProjectVMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? customerId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$ProjectVMImplCopyWith<$Res>
    implements $ProjectVMCopyWith<$Res> {
  factory _$$ProjectVMImplCopyWith(
          _$ProjectVMImpl value, $Res Function(_$ProjectVMImpl) then) =
      __$$ProjectVMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? title, int? customerId});
}

/// @nodoc
class __$$ProjectVMImplCopyWithImpl<$Res>
    extends _$ProjectVMCopyWithImpl<$Res, _$ProjectVMImpl>
    implements _$$ProjectVMImplCopyWith<$Res> {
  __$$ProjectVMImplCopyWithImpl(
      _$ProjectVMImpl _value, $Res Function(_$ProjectVMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? customerId = freezed,
  }) {
    return _then(_$ProjectVMImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$ProjectVMImpl implements _ProjectVM {
  const _$ProjectVMImpl({required this.id, this.title, this.customerId});

  factory _$ProjectVMImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectVMImplFromJson(json);

  @override
  final int id;
  @override
  final String? title;
  @override
  final int? customerId;

  @override
  String toString() {
    return 'ProjectVM(id: $id, title: $title, customerId: $customerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectVMImpl &&
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
  _$$ProjectVMImplCopyWith<_$ProjectVMImpl> get copyWith =>
      __$$ProjectVMImplCopyWithImpl<_$ProjectVMImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectVMImplToJson(
      this,
    );
  }
}

abstract class _ProjectVM implements ProjectVM {
  const factory _ProjectVM(
      {required final int id,
      final String? title,
      final int? customerId}) = _$ProjectVMImpl;

  factory _ProjectVM.fromJson(Map<String, dynamic> json) =
      _$ProjectVMImpl.fromJson;

  @override
  int get id;
  @override
  String? get title;
  @override
  int? get customerId;
  @override
  @JsonKey(ignore: true)
  _$$ProjectVMImplCopyWith<_$ProjectVMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
