// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_projects_report_dm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomerProjectsReportDM _$CustomerProjectsReportDMFromJson(
    Map<String, dynamic> json) {
  return _CustomerProjectsReportDM.fromJson(json);
}

/// @nodoc
mixin _$CustomerProjectsReportDM {
  CustomerCredentialDM get customerCredentials =>
      throw _privateConstructorUsedError;
  String? get customerName =>
      throw _privateConstructorUsedError; // @Default(0.0) double customerRevenue,
  double? get customerRevenue => throw _privateConstructorUsedError;
  List<ProjectRepotsDM> get projectsList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerProjectsReportDMCopyWith<CustomerProjectsReportDM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerProjectsReportDMCopyWith<$Res> {
  factory $CustomerProjectsReportDMCopyWith(CustomerProjectsReportDM value,
          $Res Function(CustomerProjectsReportDM) then) =
      _$CustomerProjectsReportDMCopyWithImpl<$Res, CustomerProjectsReportDM>;
  @useResult
  $Res call(
      {CustomerCredentialDM customerCredentials,
      String? customerName,
      double? customerRevenue,
      List<ProjectRepotsDM> projectsList});

  $CustomerCredentialDMCopyWith<$Res> get customerCredentials;
}

/// @nodoc
class _$CustomerProjectsReportDMCopyWithImpl<$Res,
        $Val extends CustomerProjectsReportDM>
    implements $CustomerProjectsReportDMCopyWith<$Res> {
  _$CustomerProjectsReportDMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerCredentials = null,
    Object? customerName = freezed,
    Object? customerRevenue = freezed,
    Object? projectsList = null,
  }) {
    return _then(_value.copyWith(
      customerCredentials: null == customerCredentials
          ? _value.customerCredentials
          : customerCredentials // ignore: cast_nullable_to_non_nullable
              as CustomerCredentialDM,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      customerRevenue: freezed == customerRevenue
          ? _value.customerRevenue
          : customerRevenue // ignore: cast_nullable_to_non_nullable
              as double?,
      projectsList: null == projectsList
          ? _value.projectsList
          : projectsList // ignore: cast_nullable_to_non_nullable
              as List<ProjectRepotsDM>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomerCredentialDMCopyWith<$Res> get customerCredentials {
    return $CustomerCredentialDMCopyWith<$Res>(_value.customerCredentials,
        (value) {
      return _then(_value.copyWith(customerCredentials: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomerProjectsReportDMImplCopyWith<$Res>
    implements $CustomerProjectsReportDMCopyWith<$Res> {
  factory _$$CustomerProjectsReportDMImplCopyWith(
          _$CustomerProjectsReportDMImpl value,
          $Res Function(_$CustomerProjectsReportDMImpl) then) =
      __$$CustomerProjectsReportDMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CustomerCredentialDM customerCredentials,
      String? customerName,
      double? customerRevenue,
      List<ProjectRepotsDM> projectsList});

  @override
  $CustomerCredentialDMCopyWith<$Res> get customerCredentials;
}

/// @nodoc
class __$$CustomerProjectsReportDMImplCopyWithImpl<$Res>
    extends _$CustomerProjectsReportDMCopyWithImpl<$Res,
        _$CustomerProjectsReportDMImpl>
    implements _$$CustomerProjectsReportDMImplCopyWith<$Res> {
  __$$CustomerProjectsReportDMImplCopyWithImpl(
      _$CustomerProjectsReportDMImpl _value,
      $Res Function(_$CustomerProjectsReportDMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerCredentials = null,
    Object? customerName = freezed,
    Object? customerRevenue = freezed,
    Object? projectsList = null,
  }) {
    return _then(_$CustomerProjectsReportDMImpl(
      customerCredentials: null == customerCredentials
          ? _value.customerCredentials
          : customerCredentials // ignore: cast_nullable_to_non_nullable
              as CustomerCredentialDM,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      customerRevenue: freezed == customerRevenue
          ? _value.customerRevenue
          : customerRevenue // ignore: cast_nullable_to_non_nullable
              as double?,
      projectsList: null == projectsList
          ? _value._projectsList
          : projectsList // ignore: cast_nullable_to_non_nullable
              as List<ProjectRepotsDM>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerProjectsReportDMImpl extends _CustomerProjectsReportDM {
  _$CustomerProjectsReportDMImpl(
      {required this.customerCredentials,
      this.customerName,
      this.customerRevenue,
      final List<ProjectRepotsDM> projectsList = const []})
      : _projectsList = projectsList,
        super._();

  factory _$CustomerProjectsReportDMImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerProjectsReportDMImplFromJson(json);

  @override
  final CustomerCredentialDM customerCredentials;
  @override
  final String? customerName;
// @Default(0.0) double customerRevenue,
  @override
  final double? customerRevenue;
  final List<ProjectRepotsDM> _projectsList;
  @override
  @JsonKey()
  List<ProjectRepotsDM> get projectsList {
    if (_projectsList is EqualUnmodifiableListView) return _projectsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projectsList);
  }

  @override
  String toString() {
    return 'CustomerProjectsReportDM(customerCredentials: $customerCredentials, customerName: $customerName, customerRevenue: $customerRevenue, projectsList: $projectsList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerProjectsReportDMImpl &&
            (identical(other.customerCredentials, customerCredentials) ||
                other.customerCredentials == customerCredentials) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerRevenue, customerRevenue) ||
                other.customerRevenue == customerRevenue) &&
            const DeepCollectionEquality()
                .equals(other._projectsList, _projectsList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      customerCredentials,
      customerName,
      customerRevenue,
      const DeepCollectionEquality().hash(_projectsList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerProjectsReportDMImplCopyWith<_$CustomerProjectsReportDMImpl>
      get copyWith => __$$CustomerProjectsReportDMImplCopyWithImpl<
          _$CustomerProjectsReportDMImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerProjectsReportDMImplToJson(
      this,
    );
  }
}

abstract class _CustomerProjectsReportDM extends CustomerProjectsReportDM {
  factory _CustomerProjectsReportDM(
          {required final CustomerCredentialDM customerCredentials,
          final String? customerName,
          final double? customerRevenue,
          final List<ProjectRepotsDM> projectsList}) =
      _$CustomerProjectsReportDMImpl;
  _CustomerProjectsReportDM._() : super._();

  factory _CustomerProjectsReportDM.fromJson(Map<String, dynamic> json) =
      _$CustomerProjectsReportDMImpl.fromJson;

  @override
  CustomerCredentialDM get customerCredentials;
  @override
  String? get customerName;
  @override // @Default(0.0) double customerRevenue,
  double? get customerRevenue;
  @override
  List<ProjectRepotsDM> get projectsList;
  @override
  @JsonKey(ignore: true)
  _$$CustomerProjectsReportDMImplCopyWith<_$CustomerProjectsReportDMImpl>
      get copyWith => throw _privateConstructorUsedError;
}
