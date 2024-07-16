// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_vm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeVMAdapter _$TimeVMAdapterFromJson(Map<String, dynamic> json) {
  return _TimeVMAdapter.fromJson(json);
}

/// @nodoc
mixin _$TimeVMAdapter {
  UserDataShort? get user => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  DateTime? get pauseEnd => throw _privateConstructorUsedError;
  DateTime? get pauseStart => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  ProjectShortVM? get project => throw _privateConstructorUsedError;
  ServiceVM? get service => throw _privateConstructorUsedError;
  String? get customerName => throw _privateConstructorUsedError;
  int? get customerId => throw _privateConstructorUsedError;
  TimeEntryType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeVMAdapterCopyWith<TimeVMAdapter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeVMAdapterCopyWith<$Res> {
  factory $TimeVMAdapterCopyWith(
          TimeVMAdapter value, $Res Function(TimeVMAdapter) then) =
      _$TimeVMAdapterCopyWithImpl<$Res, TimeVMAdapter>;
  @useResult
  $Res call(
      {UserDataShort? user,
      DateTime startTime,
      DateTime endTime,
      DateTime? pauseEnd,
      DateTime? pauseStart,
      int? id,
      DateTime date,
      String? description,
      int? duration,
      ProjectShortVM? project,
      ServiceVM? service,
      String? customerName,
      int? customerId,
      TimeEntryType type});

  $UserDataShortCopyWith<$Res>? get user;
  $ProjectShortVMCopyWith<$Res>? get project;
  $ServiceVMCopyWith<$Res>? get service;
}

/// @nodoc
class _$TimeVMAdapterCopyWithImpl<$Res, $Val extends TimeVMAdapter>
    implements $TimeVMAdapterCopyWith<$Res> {
  _$TimeVMAdapterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? pauseEnd = freezed,
    Object? pauseStart = freezed,
    Object? id = freezed,
    Object? date = null,
    Object? description = freezed,
    Object? duration = freezed,
    Object? project = freezed,
    Object? service = freezed,
    Object? customerName = freezed,
    Object? customerId = freezed,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserDataShort?,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pauseEnd: freezed == pauseEnd
          ? _value.pauseEnd
          : pauseEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pauseStart: freezed == pauseStart
          ? _value.pauseStart
          : pauseStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      project: freezed == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as ProjectShortVM?,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as ServiceVM?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TimeEntryType,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDataShortCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserDataShortCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProjectShortVMCopyWith<$Res>? get project {
    if (_value.project == null) {
      return null;
    }

    return $ProjectShortVMCopyWith<$Res>(_value.project!, (value) {
      return _then(_value.copyWith(project: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ServiceVMCopyWith<$Res>? get service {
    if (_value.service == null) {
      return null;
    }

    return $ServiceVMCopyWith<$Res>(_value.service!, (value) {
      return _then(_value.copyWith(service: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TimeVMAdapterImplCopyWith<$Res>
    implements $TimeVMAdapterCopyWith<$Res> {
  factory _$$TimeVMAdapterImplCopyWith(
          _$TimeVMAdapterImpl value, $Res Function(_$TimeVMAdapterImpl) then) =
      __$$TimeVMAdapterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserDataShort? user,
      DateTime startTime,
      DateTime endTime,
      DateTime? pauseEnd,
      DateTime? pauseStart,
      int? id,
      DateTime date,
      String? description,
      int? duration,
      ProjectShortVM? project,
      ServiceVM? service,
      String? customerName,
      int? customerId,
      TimeEntryType type});

  @override
  $UserDataShortCopyWith<$Res>? get user;
  @override
  $ProjectShortVMCopyWith<$Res>? get project;
  @override
  $ServiceVMCopyWith<$Res>? get service;
}

/// @nodoc
class __$$TimeVMAdapterImplCopyWithImpl<$Res>
    extends _$TimeVMAdapterCopyWithImpl<$Res, _$TimeVMAdapterImpl>
    implements _$$TimeVMAdapterImplCopyWith<$Res> {
  __$$TimeVMAdapterImplCopyWithImpl(
      _$TimeVMAdapterImpl _value, $Res Function(_$TimeVMAdapterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? pauseEnd = freezed,
    Object? pauseStart = freezed,
    Object? id = freezed,
    Object? date = null,
    Object? description = freezed,
    Object? duration = freezed,
    Object? project = freezed,
    Object? service = freezed,
    Object? customerName = freezed,
    Object? customerId = freezed,
    Object? type = null,
  }) {
    return _then(_$TimeVMAdapterImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserDataShort?,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pauseEnd: freezed == pauseEnd
          ? _value.pauseEnd
          : pauseEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pauseStart: freezed == pauseStart
          ? _value.pauseStart
          : pauseStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      project: freezed == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as ProjectShortVM?,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as ServiceVM?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TimeEntryType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeVMAdapterImpl extends _TimeVMAdapter {
  const _$TimeVMAdapterImpl(
      {this.user,
      required this.startTime,
      required this.endTime,
      this.pauseEnd,
      this.pauseStart,
      this.id,
      required this.date,
      this.description,
      this.duration,
      this.project,
      this.service,
      this.customerName,
      this.customerId,
      this.type = TimeEntryType.workOrder})
      : super._();

  factory _$TimeVMAdapterImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeVMAdapterImplFromJson(json);

  @override
  final UserDataShort? user;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final DateTime? pauseEnd;
  @override
  final DateTime? pauseStart;
  @override
  final int? id;
  @override
  final DateTime date;
  @override
  final String? description;
  @override
  final int? duration;
  @override
  final ProjectShortVM? project;
  @override
  final ServiceVM? service;
  @override
  final String? customerName;
  @override
  final int? customerId;
  @override
  @JsonKey()
  final TimeEntryType type;

  @override
  String toString() {
    return 'TimeVMAdapter(user: $user, startTime: $startTime, endTime: $endTime, pauseEnd: $pauseEnd, pauseStart: $pauseStart, id: $id, date: $date, description: $description, duration: $duration, project: $project, service: $service, customerName: $customerName, customerId: $customerId, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeVMAdapterImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.pauseEnd, pauseEnd) ||
                other.pauseEnd == pauseEnd) &&
            (identical(other.pauseStart, pauseStart) ||
                other.pauseStart == pauseStart) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.project, project) || other.project == project) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      user,
      startTime,
      endTime,
      pauseEnd,
      pauseStart,
      id,
      date,
      description,
      duration,
      project,
      service,
      customerName,
      customerId,
      type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeVMAdapterImplCopyWith<_$TimeVMAdapterImpl> get copyWith =>
      __$$TimeVMAdapterImplCopyWithImpl<_$TimeVMAdapterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeVMAdapterImplToJson(
      this,
    );
  }
}

abstract class _TimeVMAdapter extends TimeVMAdapter {
  const factory _TimeVMAdapter(
      {final UserDataShort? user,
      required final DateTime startTime,
      required final DateTime endTime,
      final DateTime? pauseEnd,
      final DateTime? pauseStart,
      final int? id,
      required final DateTime date,
      final String? description,
      final int? duration,
      final ProjectShortVM? project,
      final ServiceVM? service,
      final String? customerName,
      final int? customerId,
      final TimeEntryType type}) = _$TimeVMAdapterImpl;
  const _TimeVMAdapter._() : super._();

  factory _TimeVMAdapter.fromJson(Map<String, dynamic> json) =
      _$TimeVMAdapterImpl.fromJson;

  @override
  UserDataShort? get user;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  DateTime? get pauseEnd;
  @override
  DateTime? get pauseStart;
  @override
  int? get id;
  @override
  DateTime get date;
  @override
  String? get description;
  @override
  int? get duration;
  @override
  ProjectShortVM? get project;
  @override
  ServiceVM? get service;
  @override
  String? get customerName;
  @override
  int? get customerId;
  @override
  TimeEntryType get type;
  @override
  @JsonKey(ignore: true)
  _$$TimeVMAdapterImplCopyWith<_$TimeVMAdapterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
