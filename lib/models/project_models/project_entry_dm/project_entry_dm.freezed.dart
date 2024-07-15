// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_entry_dm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectEntryDM _$ProjectEntryDMFromJson(Map<String, dynamic> json) {
  return _ProjectEntryDM.fromJson(json);
}

/// @nodoc
mixin _$ProjectEntryDM {
  String? get title => throw _privateConstructorUsedError;
  String? get dateOfStart => throw _privateConstructorUsedError;
  String? get dateOfTermination => throw _privateConstructorUsedError;
  int? get projectStatusId => throw _privateConstructorUsedError;
  int? get customerId => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectEntryDMCopyWith<ProjectEntryDM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectEntryDMCopyWith<$Res> {
  factory $ProjectEntryDMCopyWith(
          ProjectEntryDM value, $Res Function(ProjectEntryDM) then) =
      _$ProjectEntryDMCopyWithImpl<$Res, ProjectEntryDM>;
  @useResult
  $Res call(
      {String? title,
      String? dateOfStart,
      String? dateOfTermination,
      int? projectStatusId,
      int? customerId,
      String? description,
      int? id});
}

/// @nodoc
class _$ProjectEntryDMCopyWithImpl<$Res, $Val extends ProjectEntryDM>
    implements $ProjectEntryDMCopyWith<$Res> {
  _$ProjectEntryDMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? dateOfStart = freezed,
    Object? dateOfTermination = freezed,
    Object? projectStatusId = freezed,
    Object? customerId = freezed,
    Object? description = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfStart: freezed == dateOfStart
          ? _value.dateOfStart
          : dateOfStart // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfTermination: freezed == dateOfTermination
          ? _value.dateOfTermination
          : dateOfTermination // ignore: cast_nullable_to_non_nullable
              as String?,
      projectStatusId: freezed == projectStatusId
          ? _value.projectStatusId
          : projectStatusId // ignore: cast_nullable_to_non_nullable
              as int?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectEntryDMImplCopyWith<$Res>
    implements $ProjectEntryDMCopyWith<$Res> {
  factory _$$ProjectEntryDMImplCopyWith(_$ProjectEntryDMImpl value,
          $Res Function(_$ProjectEntryDMImpl) then) =
      __$$ProjectEntryDMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? dateOfStart,
      String? dateOfTermination,
      int? projectStatusId,
      int? customerId,
      String? description,
      int? id});
}

/// @nodoc
class __$$ProjectEntryDMImplCopyWithImpl<$Res>
    extends _$ProjectEntryDMCopyWithImpl<$Res, _$ProjectEntryDMImpl>
    implements _$$ProjectEntryDMImplCopyWith<$Res> {
  __$$ProjectEntryDMImplCopyWithImpl(
      _$ProjectEntryDMImpl _value, $Res Function(_$ProjectEntryDMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? dateOfStart = freezed,
    Object? dateOfTermination = freezed,
    Object? projectStatusId = freezed,
    Object? customerId = freezed,
    Object? description = freezed,
    Object? id = freezed,
  }) {
    return _then(_$ProjectEntryDMImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfStart: freezed == dateOfStart
          ? _value.dateOfStart
          : dateOfStart // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfTermination: freezed == dateOfTermination
          ? _value.dateOfTermination
          : dateOfTermination // ignore: cast_nullable_to_non_nullable
              as String?,
      projectStatusId: freezed == projectStatusId
          ? _value.projectStatusId
          : projectStatusId // ignore: cast_nullable_to_non_nullable
              as int?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectEntryDMImpl implements _ProjectEntryDM {
  const _$ProjectEntryDMImpl(
      {this.title,
      this.dateOfStart,
      this.dateOfTermination,
      this.projectStatusId,
      this.customerId,
      this.description,
      this.id});

  factory _$ProjectEntryDMImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectEntryDMImplFromJson(json);

  @override
  final String? title;
  @override
  final String? dateOfStart;
  @override
  final String? dateOfTermination;
  @override
  final int? projectStatusId;
  @override
  final int? customerId;
  @override
  final String? description;
  @override
  final int? id;

  @override
  String toString() {
    return 'ProjectEntryDM(title: $title, dateOfStart: $dateOfStart, dateOfTermination: $dateOfTermination, projectStatusId: $projectStatusId, customerId: $customerId, description: $description, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectEntryDMImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.dateOfStart, dateOfStart) ||
                other.dateOfStart == dateOfStart) &&
            (identical(other.dateOfTermination, dateOfTermination) ||
                other.dateOfTermination == dateOfTermination) &&
            (identical(other.projectStatusId, projectStatusId) ||
                other.projectStatusId == projectStatusId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, dateOfStart,
      dateOfTermination, projectStatusId, customerId, description, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectEntryDMImplCopyWith<_$ProjectEntryDMImpl> get copyWith =>
      __$$ProjectEntryDMImplCopyWithImpl<_$ProjectEntryDMImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectEntryDMImplToJson(
      this,
    );
  }
}

abstract class _ProjectEntryDM implements ProjectEntryDM {
  const factory _ProjectEntryDM(
      {final String? title,
      final String? dateOfStart,
      final String? dateOfTermination,
      final int? projectStatusId,
      final int? customerId,
      final String? description,
      final int? id}) = _$ProjectEntryDMImpl;

  factory _ProjectEntryDM.fromJson(Map<String, dynamic> json) =
      _$ProjectEntryDMImpl.fromJson;

  @override
  String? get title;
  @override
  String? get dateOfStart;
  @override
  String? get dateOfTermination;
  @override
  int? get projectStatusId;
  @override
  int? get customerId;
  @override
  String? get description;
  @override
  int? get id;
  @override
  @JsonKey(ignore: true)
  _$$ProjectEntryDMImplCopyWith<_$ProjectEntryDMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
