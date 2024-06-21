// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_dm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeEntry _$TimeEntryFromJson(Map<String, dynamic> json) {
  return _TimeEntry.fromJson(json);
}

/// @nodoc
mixin _$TimeEntry {
  DateTime get date => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  DateTime? get pauseEnd => throw _privateConstructorUsedError;
  DateTime? get pauseStart => throw _privateConstructorUsedError;
  int? get projectId => throw _privateConstructorUsedError;
  int? get serviceId => throw _privateConstructorUsedError;
  int? get userServiceId => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  int? get customerId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeEntryCopyWith<TimeEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeEntryCopyWith<$Res> {
  factory $TimeEntryCopyWith(TimeEntry value, $Res Function(TimeEntry) then) =
      _$TimeEntryCopyWithImpl<$Res, TimeEntry>;
  @useResult
  $Res call(
      {DateTime date,
      String? description,
      int? duration,
      DateTime endTime,
      int? id,
      DateTime? pauseEnd,
      DateTime? pauseStart,
      int? projectId,
      int? serviceId,
      int? userServiceId,
      DateTime startTime,
      int type,
      String? userId,
      int? customerId});
}

/// @nodoc
class _$TimeEntryCopyWithImpl<$Res, $Val extends TimeEntry>
    implements $TimeEntryCopyWith<$Res> {
  _$TimeEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? description = freezed,
    Object? duration = freezed,
    Object? endTime = null,
    Object? id = freezed,
    Object? pauseEnd = freezed,
    Object? pauseStart = freezed,
    Object? projectId = freezed,
    Object? serviceId = freezed,
    Object? userServiceId = freezed,
    Object? startTime = null,
    Object? type = null,
    Object? userId = freezed,
    Object? customerId = freezed,
  }) {
    return _then(_value.copyWith(
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
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      pauseEnd: freezed == pauseEnd
          ? _value.pauseEnd
          : pauseEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pauseStart: freezed == pauseStart
          ? _value.pauseStart
          : pauseStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      projectId: freezed == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      userServiceId: freezed == userServiceId
          ? _value.userServiceId
          : userServiceId // ignore: cast_nullable_to_non_nullable
              as int?,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeEntryImplCopyWith<$Res>
    implements $TimeEntryCopyWith<$Res> {
  factory _$$TimeEntryImplCopyWith(
          _$TimeEntryImpl value, $Res Function(_$TimeEntryImpl) then) =
      __$$TimeEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      String? description,
      int? duration,
      DateTime endTime,
      int? id,
      DateTime? pauseEnd,
      DateTime? pauseStart,
      int? projectId,
      int? serviceId,
      int? userServiceId,
      DateTime startTime,
      int type,
      String? userId,
      int? customerId});
}

/// @nodoc
class __$$TimeEntryImplCopyWithImpl<$Res>
    extends _$TimeEntryCopyWithImpl<$Res, _$TimeEntryImpl>
    implements _$$TimeEntryImplCopyWith<$Res> {
  __$$TimeEntryImplCopyWithImpl(
      _$TimeEntryImpl _value, $Res Function(_$TimeEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? description = freezed,
    Object? duration = freezed,
    Object? endTime = null,
    Object? id = freezed,
    Object? pauseEnd = freezed,
    Object? pauseStart = freezed,
    Object? projectId = freezed,
    Object? serviceId = freezed,
    Object? userServiceId = freezed,
    Object? startTime = null,
    Object? type = null,
    Object? userId = freezed,
    Object? customerId = freezed,
  }) {
    return _then(_$TimeEntryImpl(
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
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      pauseEnd: freezed == pauseEnd
          ? _value.pauseEnd
          : pauseEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pauseStart: freezed == pauseStart
          ? _value.pauseStart
          : pauseStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      projectId: freezed == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      userServiceId: freezed == userServiceId
          ? _value.userServiceId
          : userServiceId // ignore: cast_nullable_to_non_nullable
              as int?,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
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
class _$TimeEntryImpl extends _TimeEntry {
  const _$TimeEntryImpl(
      {required this.date,
      this.description,
      this.duration,
      required this.endTime,
      this.id,
      this.pauseEnd,
      this.pauseStart,
      this.projectId,
      this.serviceId,
      this.userServiceId,
      required this.startTime,
      this.type = 1,
      this.userId,
      this.customerId})
      : super._();

  factory _$TimeEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeEntryImplFromJson(json);

  @override
  final DateTime date;
  @override
  final String? description;
  @override
  final int? duration;
  @override
  final DateTime endTime;
  @override
  final int? id;
  @override
  final DateTime? pauseEnd;
  @override
  final DateTime? pauseStart;
  @override
  final int? projectId;
  @override
  final int? serviceId;
  @override
  final int? userServiceId;
  @override
  final DateTime startTime;
  @override
  @JsonKey()
  final int type;
  @override
  final String? userId;
  @override
  final int? customerId;

  @override
  String toString() {
    return 'TimeEntry(date: $date, description: $description, duration: $duration, endTime: $endTime, id: $id, pauseEnd: $pauseEnd, pauseStart: $pauseStart, projectId: $projectId, serviceId: $serviceId, userServiceId: $userServiceId, startTime: $startTime, type: $type, userId: $userId, customerId: $customerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeEntryImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pauseEnd, pauseEnd) ||
                other.pauseEnd == pauseEnd) &&
            (identical(other.pauseStart, pauseStart) ||
                other.pauseStart == pauseStart) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.userServiceId, userServiceId) ||
                other.userServiceId == userServiceId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      description,
      duration,
      endTime,
      id,
      pauseEnd,
      pauseStart,
      projectId,
      serviceId,
      userServiceId,
      startTime,
      type,
      userId,
      customerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeEntryImplCopyWith<_$TimeEntryImpl> get copyWith =>
      __$$TimeEntryImplCopyWithImpl<_$TimeEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeEntryImplToJson(
      this,
    );
  }
}

abstract class _TimeEntry extends TimeEntry {
  const factory _TimeEntry(
      {required final DateTime date,
      final String? description,
      final int? duration,
      required final DateTime endTime,
      final int? id,
      final DateTime? pauseEnd,
      final DateTime? pauseStart,
      final int? projectId,
      final int? serviceId,
      final int? userServiceId,
      required final DateTime startTime,
      final int type,
      final String? userId,
      final int? customerId}) = _$TimeEntryImpl;
  const _TimeEntry._() : super._();

  factory _TimeEntry.fromJson(Map<String, dynamic> json) =
      _$TimeEntryImpl.fromJson;

  @override
  DateTime get date;
  @override
  String? get description;
  @override
  int? get duration;
  @override
  DateTime get endTime;
  @override
  int? get id;
  @override
  DateTime? get pauseEnd;
  @override
  DateTime? get pauseStart;
  @override
  int? get projectId;
  @override
  int? get serviceId;
  @override
  int? get userServiceId;
  @override
  DateTime get startTime;
  @override
  int get type;
  @override
  String? get userId;
  @override
  int? get customerId;
  @override
  @JsonKey(ignore: true)
  _$$TimeEntryImplCopyWith<_$TimeEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
