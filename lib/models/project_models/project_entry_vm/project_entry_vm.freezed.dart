// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_entry_vm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectEntryVM _$ProjectEntryVMFromJson(Map<String, dynamic> json) {
  return _ProjectEntryVM.fromJson(json);
}

/// @nodoc
mixin _$ProjectEntryVM {
  String get title => throw _privateConstructorUsedError;
  DateTime get start => throw _privateConstructorUsedError;
  DateTime get terminationDate => throw _privateConstructorUsedError;
  ProjectState get state => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  CustomerShortDM? get customer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectEntryVMCopyWith<ProjectEntryVM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectEntryVMCopyWith<$Res> {
  factory $ProjectEntryVMCopyWith(
          ProjectEntryVM value, $Res Function(ProjectEntryVM) then) =
      _$ProjectEntryVMCopyWithImpl<$Res, ProjectEntryVM>;
  @useResult
  $Res call(
      {String title,
      DateTime start,
      DateTime terminationDate,
      ProjectState state,
      String? description,
      int? id,
      CustomerShortDM? customer});

  $CustomerShortDMCopyWith<$Res>? get customer;
}

/// @nodoc
class _$ProjectEntryVMCopyWithImpl<$Res, $Val extends ProjectEntryVM>
    implements $ProjectEntryVMCopyWith<$Res> {
  _$ProjectEntryVMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? start = null,
    Object? terminationDate = null,
    Object? state = null,
    Object? description = freezed,
    Object? id = freezed,
    Object? customer = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      terminationDate: null == terminationDate
          ? _value.terminationDate
          : terminationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ProjectState,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerShortDM?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomerShortDMCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $CustomerShortDMCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProjectEntryVMImplCopyWith<$Res>
    implements $ProjectEntryVMCopyWith<$Res> {
  factory _$$ProjectEntryVMImplCopyWith(_$ProjectEntryVMImpl value,
          $Res Function(_$ProjectEntryVMImpl) then) =
      __$$ProjectEntryVMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      DateTime start,
      DateTime terminationDate,
      ProjectState state,
      String? description,
      int? id,
      CustomerShortDM? customer});

  @override
  $CustomerShortDMCopyWith<$Res>? get customer;
}

/// @nodoc
class __$$ProjectEntryVMImplCopyWithImpl<$Res>
    extends _$ProjectEntryVMCopyWithImpl<$Res, _$ProjectEntryVMImpl>
    implements _$$ProjectEntryVMImplCopyWith<$Res> {
  __$$ProjectEntryVMImplCopyWithImpl(
      _$ProjectEntryVMImpl _value, $Res Function(_$ProjectEntryVMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? start = null,
    Object? terminationDate = null,
    Object? state = null,
    Object? description = freezed,
    Object? id = freezed,
    Object? customer = freezed,
  }) {
    return _then(_$ProjectEntryVMImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      terminationDate: null == terminationDate
          ? _value.terminationDate
          : terminationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ProjectState,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerShortDM?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectEntryVMImpl extends _ProjectEntryVM {
  const _$ProjectEntryVMImpl(
      {required this.title,
      required this.start,
      required this.terminationDate,
      this.state = ProjectState.planning,
      this.description,
      this.id,
      this.customer})
      : super._();

  factory _$ProjectEntryVMImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectEntryVMImplFromJson(json);

  @override
  final String title;
  @override
  final DateTime start;
  @override
  final DateTime terminationDate;
  @override
  @JsonKey()
  final ProjectState state;
  @override
  final String? description;
  @override
  final int? id;
  @override
  final CustomerShortDM? customer;

  @override
  String toString() {
    return 'ProjectEntryVM(title: $title, start: $start, terminationDate: $terminationDate, state: $state, description: $description, id: $id, customer: $customer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectEntryVMImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.terminationDate, terminationDate) ||
                other.terminationDate == terminationDate) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customer, customer) ||
                other.customer == customer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, start, terminationDate,
      state, description, id, customer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectEntryVMImplCopyWith<_$ProjectEntryVMImpl> get copyWith =>
      __$$ProjectEntryVMImplCopyWithImpl<_$ProjectEntryVMImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectEntryVMImplToJson(
      this,
    );
  }
}

abstract class _ProjectEntryVM extends ProjectEntryVM {
  const factory _ProjectEntryVM(
      {required final String title,
      required final DateTime start,
      required final DateTime terminationDate,
      final ProjectState state,
      final String? description,
      final int? id,
      final CustomerShortDM? customer}) = _$ProjectEntryVMImpl;
  const _ProjectEntryVM._() : super._();

  factory _ProjectEntryVM.fromJson(Map<String, dynamic> json) =
      _$ProjectEntryVMImpl.fromJson;

  @override
  String get title;
  @override
  DateTime get start;
  @override
  DateTime get terminationDate;
  @override
  ProjectState get state;
  @override
  String? get description;
  @override
  int? get id;
  @override
  CustomerShortDM? get customer;
  @override
  @JsonKey(ignore: true)
  _$$ProjectEntryVMImplCopyWith<_$ProjectEntryVMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
