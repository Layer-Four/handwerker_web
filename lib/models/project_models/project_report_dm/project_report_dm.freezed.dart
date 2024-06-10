// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_report_dm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectRepotsDM _$ProjectRepotsDMFromJson(Map<String, dynamic> json) {
  return _ProjectRepotsDM.fromJson(json);
}

/// @nodoc
mixin _$ProjectRepotsDM {
  String get customerName => throw _privateConstructorUsedError;
  List<ConsumableVM>? get materials => throw _privateConstructorUsedError;
  int get projectID => throw _privateConstructorUsedError;
  String get projectName => throw _privateConstructorUsedError;
  List<ServiceVM>? get services => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get timeRange => throw _privateConstructorUsedError;
  int get turnover => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectRepotsDMCopyWith<ProjectRepotsDM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectRepotsDMCopyWith<$Res> {
  factory $ProjectRepotsDMCopyWith(
          ProjectRepotsDM value, $Res Function(ProjectRepotsDM) then) =
      _$ProjectRepotsDMCopyWithImpl<$Res, ProjectRepotsDM>;
  @useResult
  $Res call(
      {String customerName,
      List<ConsumableVM>? materials,
      int projectID,
      String projectName,
      List<ServiceVM>? services,
      String? state,
      String? timeRange,
      int turnover});
}

/// @nodoc
class _$ProjectRepotsDMCopyWithImpl<$Res, $Val extends ProjectRepotsDM>
    implements $ProjectRepotsDMCopyWith<$Res> {
  _$ProjectRepotsDMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerName = null,
    Object? materials = freezed,
    Object? projectID = null,
    Object? projectName = null,
    Object? services = freezed,
    Object? state = freezed,
    Object? timeRange = freezed,
    Object? turnover = null,
  }) {
    return _then(_value.copyWith(
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      materials: freezed == materials
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as List<ConsumableVM>?,
      projectID: null == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int,
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
      services: freezed == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<ServiceVM>?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      timeRange: freezed == timeRange
          ? _value.timeRange
          : timeRange // ignore: cast_nullable_to_non_nullable
              as String?,
      turnover: null == turnover
          ? _value.turnover
          : turnover // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectRepotsDMImplCopyWith<$Res>
    implements $ProjectRepotsDMCopyWith<$Res> {
  factory _$$ProjectRepotsDMImplCopyWith(_$ProjectRepotsDMImpl value,
          $Res Function(_$ProjectRepotsDMImpl) then) =
      __$$ProjectRepotsDMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String customerName,
      List<ConsumableVM>? materials,
      int projectID,
      String projectName,
      List<ServiceVM>? services,
      String? state,
      String? timeRange,
      int turnover});
}

/// @nodoc
class __$$ProjectRepotsDMImplCopyWithImpl<$Res>
    extends _$ProjectRepotsDMCopyWithImpl<$Res, _$ProjectRepotsDMImpl>
    implements _$$ProjectRepotsDMImplCopyWith<$Res> {
  __$$ProjectRepotsDMImplCopyWithImpl(
      _$ProjectRepotsDMImpl _value, $Res Function(_$ProjectRepotsDMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerName = null,
    Object? materials = freezed,
    Object? projectID = null,
    Object? projectName = null,
    Object? services = freezed,
    Object? state = freezed,
    Object? timeRange = freezed,
    Object? turnover = null,
  }) {
    return _then(_$ProjectRepotsDMImpl(
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      materials: freezed == materials
          ? _value._materials
          : materials // ignore: cast_nullable_to_non_nullable
              as List<ConsumableVM>?,
      projectID: null == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int,
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
      services: freezed == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<ServiceVM>?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      timeRange: freezed == timeRange
          ? _value.timeRange
          : timeRange // ignore: cast_nullable_to_non_nullable
              as String?,
      turnover: null == turnover
          ? _value.turnover
          : turnover // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectRepotsDMImpl extends _ProjectRepotsDM {
  const _$ProjectRepotsDMImpl(
      {required this.customerName,
      final List<ConsumableVM>? materials,
      required this.projectID,
      required this.projectName,
      final List<ServiceVM>? services,
      this.state,
      this.timeRange,
      required this.turnover})
      : _materials = materials,
        _services = services,
        super._();

  factory _$ProjectRepotsDMImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectRepotsDMImplFromJson(json);

  @override
  final String customerName;
  final List<ConsumableVM>? _materials;
  @override
  List<ConsumableVM>? get materials {
    final value = _materials;
    if (value == null) return null;
    if (_materials is EqualUnmodifiableListView) return _materials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int projectID;
  @override
  final String projectName;
  final List<ServiceVM>? _services;
  @override
  List<ServiceVM>? get services {
    final value = _services;
    if (value == null) return null;
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? state;
  @override
  final String? timeRange;
  @override
  final int turnover;

  @override
  String toString() {
    return 'ProjectRepotsDM(customerName: $customerName, materials: $materials, projectID: $projectID, projectName: $projectName, services: $services, state: $state, timeRange: $timeRange, turnover: $turnover)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectRepotsDMImpl &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            const DeepCollectionEquality()
                .equals(other._materials, _materials) &&
            (identical(other.projectID, projectID) ||
                other.projectID == projectID) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            const DeepCollectionEquality().equals(other._services, _services) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.timeRange, timeRange) ||
                other.timeRange == timeRange) &&
            (identical(other.turnover, turnover) ||
                other.turnover == turnover));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      customerName,
      const DeepCollectionEquality().hash(_materials),
      projectID,
      projectName,
      const DeepCollectionEquality().hash(_services),
      state,
      timeRange,
      turnover);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectRepotsDMImplCopyWith<_$ProjectRepotsDMImpl> get copyWith =>
      __$$ProjectRepotsDMImplCopyWithImpl<_$ProjectRepotsDMImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectRepotsDMImplToJson(
      this,
    );
  }
}

abstract class _ProjectRepotsDM extends ProjectRepotsDM {
  const factory _ProjectRepotsDM(
      {required final String customerName,
      final List<ConsumableVM>? materials,
      required final int projectID,
      required final String projectName,
      final List<ServiceVM>? services,
      final String? state,
      final String? timeRange,
      required final int turnover}) = _$ProjectRepotsDMImpl;
  const _ProjectRepotsDM._() : super._();

  factory _ProjectRepotsDM.fromJson(Map<String, dynamic> json) =
      _$ProjectRepotsDMImpl.fromJson;

  @override
  String get customerName;
  @override
  List<ConsumableVM>? get materials;
  @override
  int get projectID;
  @override
  String get projectName;
  @override
  List<ServiceVM>? get services;
  @override
  String? get state;
  @override
  String? get timeRange;
  @override
  int get turnover;
  @override
  @JsonKey(ignore: true)
  _$$ProjectRepotsDMImplCopyWith<_$ProjectRepotsDMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
