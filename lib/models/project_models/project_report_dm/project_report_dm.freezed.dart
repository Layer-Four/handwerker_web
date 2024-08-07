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
  List<ProjectConsumable> get consumables => throw _privateConstructorUsedError;
  int? get projectID => throw _privateConstructorUsedError;
  DateTime? get dateOfStart => throw _privateConstructorUsedError;
  DateTime? get dateOfTermination => throw _privateConstructorUsedError;
  String? get projectDescription => throw _privateConstructorUsedError;
  String? get projectName => throw _privateConstructorUsedError;
  double? get projectRevenue => throw _privateConstructorUsedError;
  ProjectInfoState? get projectState => throw _privateConstructorUsedError;
  List<ProjectTimeEntry> get reportsList => throw _privateConstructorUsedError;
  List<ServiceProject> get serviceList => throw _privateConstructorUsedError;

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
      {List<ProjectConsumable> consumables,
      int? projectID,
      DateTime? dateOfStart,
      DateTime? dateOfTermination,
      String? projectDescription,
      String? projectName,
      double? projectRevenue,
      ProjectInfoState? projectState,
      List<ProjectTimeEntry> reportsList,
      List<ServiceProject> serviceList});

  $ProjectInfoStateCopyWith<$Res>? get projectState;
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
    Object? consumables = null,
    Object? projectID = freezed,
    Object? dateOfStart = freezed,
    Object? dateOfTermination = freezed,
    Object? projectDescription = freezed,
    Object? projectName = freezed,
    Object? projectRevenue = freezed,
    Object? projectState = freezed,
    Object? reportsList = null,
    Object? serviceList = null,
  }) {
    return _then(_value.copyWith(
      consumables: null == consumables
          ? _value.consumables
          : consumables // ignore: cast_nullable_to_non_nullable
              as List<ProjectConsumable>,
      projectID: freezed == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int?,
      dateOfStart: freezed == dateOfStart
          ? _value.dateOfStart
          : dateOfStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateOfTermination: freezed == dateOfTermination
          ? _value.dateOfTermination
          : dateOfTermination // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      projectDescription: freezed == projectDescription
          ? _value.projectDescription
          : projectDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      projectName: freezed == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String?,
      projectRevenue: freezed == projectRevenue
          ? _value.projectRevenue
          : projectRevenue // ignore: cast_nullable_to_non_nullable
              as double?,
      projectState: freezed == projectState
          ? _value.projectState
          : projectState // ignore: cast_nullable_to_non_nullable
              as ProjectInfoState?,
      reportsList: null == reportsList
          ? _value.reportsList
          : reportsList // ignore: cast_nullable_to_non_nullable
              as List<ProjectTimeEntry>,
      serviceList: null == serviceList
          ? _value.serviceList
          : serviceList // ignore: cast_nullable_to_non_nullable
              as List<ServiceProject>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProjectInfoStateCopyWith<$Res>? get projectState {
    if (_value.projectState == null) {
      return null;
    }

    return $ProjectInfoStateCopyWith<$Res>(_value.projectState!, (value) {
      return _then(_value.copyWith(projectState: value) as $Val);
    });
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
      {List<ProjectConsumable> consumables,
      int? projectID,
      DateTime? dateOfStart,
      DateTime? dateOfTermination,
      String? projectDescription,
      String? projectName,
      double? projectRevenue,
      ProjectInfoState? projectState,
      List<ProjectTimeEntry> reportsList,
      List<ServiceProject> serviceList});

  @override
  $ProjectInfoStateCopyWith<$Res>? get projectState;
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
    Object? consumables = null,
    Object? projectID = freezed,
    Object? dateOfStart = freezed,
    Object? dateOfTermination = freezed,
    Object? projectDescription = freezed,
    Object? projectName = freezed,
    Object? projectRevenue = freezed,
    Object? projectState = freezed,
    Object? reportsList = null,
    Object? serviceList = null,
  }) {
    return _then(_$ProjectRepotsDMImpl(
      consumables: null == consumables
          ? _value._consumables
          : consumables // ignore: cast_nullable_to_non_nullable
              as List<ProjectConsumable>,
      projectID: freezed == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int?,
      dateOfStart: freezed == dateOfStart
          ? _value.dateOfStart
          : dateOfStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateOfTermination: freezed == dateOfTermination
          ? _value.dateOfTermination
          : dateOfTermination // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      projectDescription: freezed == projectDescription
          ? _value.projectDescription
          : projectDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      projectName: freezed == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String?,
      projectRevenue: freezed == projectRevenue
          ? _value.projectRevenue
          : projectRevenue // ignore: cast_nullable_to_non_nullable
              as double?,
      projectState: freezed == projectState
          ? _value.projectState
          : projectState // ignore: cast_nullable_to_non_nullable
              as ProjectInfoState?,
      reportsList: null == reportsList
          ? _value._reportsList
          : reportsList // ignore: cast_nullable_to_non_nullable
              as List<ProjectTimeEntry>,
      serviceList: null == serviceList
          ? _value._serviceList
          : serviceList // ignore: cast_nullable_to_non_nullable
              as List<ServiceProject>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectRepotsDMImpl extends _ProjectRepotsDM {
  const _$ProjectRepotsDMImpl(
      {final List<ProjectConsumable> consumables = const [],
      this.projectID,
      this.dateOfStart,
      this.dateOfTermination,
      this.projectDescription,
      this.projectName,
      this.projectRevenue,
      this.projectState,
      final List<ProjectTimeEntry> reportsList = const [],
      final List<ServiceProject> serviceList = const []})
      : _consumables = consumables,
        _reportsList = reportsList,
        _serviceList = serviceList,
        super._();

  factory _$ProjectRepotsDMImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectRepotsDMImplFromJson(json);

  final List<ProjectConsumable> _consumables;
  @override
  @JsonKey()
  List<ProjectConsumable> get consumables {
    if (_consumables is EqualUnmodifiableListView) return _consumables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_consumables);
  }

  @override
  final int? projectID;
  @override
  final DateTime? dateOfStart;
  @override
  final DateTime? dateOfTermination;
  @override
  final String? projectDescription;
  @override
  final String? projectName;
  @override
  final double? projectRevenue;
  @override
  final ProjectInfoState? projectState;
  final List<ProjectTimeEntry> _reportsList;
  @override
  @JsonKey()
  List<ProjectTimeEntry> get reportsList {
    if (_reportsList is EqualUnmodifiableListView) return _reportsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reportsList);
  }

  final List<ServiceProject> _serviceList;
  @override
  @JsonKey()
  List<ServiceProject> get serviceList {
    if (_serviceList is EqualUnmodifiableListView) return _serviceList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceList);
  }

  @override
  String toString() {
    return 'ProjectRepotsDM(consumables: $consumables, projectID: $projectID, dateOfStart: $dateOfStart, dateOfTermination: $dateOfTermination, projectDescription: $projectDescription, projectName: $projectName, projectRevenue: $projectRevenue, projectState: $projectState, reportsList: $reportsList, serviceList: $serviceList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectRepotsDMImpl &&
            const DeepCollectionEquality()
                .equals(other._consumables, _consumables) &&
            (identical(other.projectID, projectID) ||
                other.projectID == projectID) &&
            (identical(other.dateOfStart, dateOfStart) ||
                other.dateOfStart == dateOfStart) &&
            (identical(other.dateOfTermination, dateOfTermination) ||
                other.dateOfTermination == dateOfTermination) &&
            (identical(other.projectDescription, projectDescription) ||
                other.projectDescription == projectDescription) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            (identical(other.projectRevenue, projectRevenue) ||
                other.projectRevenue == projectRevenue) &&
            (identical(other.projectState, projectState) ||
                other.projectState == projectState) &&
            const DeepCollectionEquality()
                .equals(other._reportsList, _reportsList) &&
            const DeepCollectionEquality()
                .equals(other._serviceList, _serviceList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_consumables),
      projectID,
      dateOfStart,
      dateOfTermination,
      projectDescription,
      projectName,
      projectRevenue,
      projectState,
      const DeepCollectionEquality().hash(_reportsList),
      const DeepCollectionEquality().hash(_serviceList));

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
      {final List<ProjectConsumable> consumables,
      final int? projectID,
      final DateTime? dateOfStart,
      final DateTime? dateOfTermination,
      final String? projectDescription,
      final String? projectName,
      final double? projectRevenue,
      final ProjectInfoState? projectState,
      final List<ProjectTimeEntry> reportsList,
      final List<ServiceProject> serviceList}) = _$ProjectRepotsDMImpl;
  const _ProjectRepotsDM._() : super._();

  factory _ProjectRepotsDM.fromJson(Map<String, dynamic> json) =
      _$ProjectRepotsDMImpl.fromJson;

  @override
  List<ProjectConsumable> get consumables;
  @override
  int? get projectID;
  @override
  DateTime? get dateOfStart;
  @override
  DateTime? get dateOfTermination;
  @override
  String? get projectDescription;
  @override
  String? get projectName;
  @override
  double? get projectRevenue;
  @override
  ProjectInfoState? get projectState;
  @override
  List<ProjectTimeEntry> get reportsList;
  @override
  List<ServiceProject> get serviceList;
  @override
  @JsonKey(ignore: true)
  _$$ProjectRepotsDMImplCopyWith<_$ProjectRepotsDMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
