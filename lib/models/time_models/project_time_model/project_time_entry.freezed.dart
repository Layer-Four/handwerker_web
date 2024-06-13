// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_time_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectTimeEntry _$ProjectTimeEntryFromJson(Map<String, dynamic> json) {
  return _ProjectTimeEntry.fromJson(json);
}

/// @nodoc
mixin _$ProjectTimeEntry {
  DateTime? get startTimeDate => throw _privateConstructorUsedError;
  String? get workDescription => throw _privateConstructorUsedError;
  List<String> get imagePathList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectTimeEntryCopyWith<ProjectTimeEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectTimeEntryCopyWith<$Res> {
  factory $ProjectTimeEntryCopyWith(
          ProjectTimeEntry value, $Res Function(ProjectTimeEntry) then) =
      _$ProjectTimeEntryCopyWithImpl<$Res, ProjectTimeEntry>;
  @useResult
  $Res call(
      {DateTime? startTimeDate,
      String? workDescription,
      List<String> imagePathList});
}

/// @nodoc
class _$ProjectTimeEntryCopyWithImpl<$Res, $Val extends ProjectTimeEntry>
    implements $ProjectTimeEntryCopyWith<$Res> {
  _$ProjectTimeEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTimeDate = freezed,
    Object? workDescription = freezed,
    Object? imagePathList = null,
  }) {
    return _then(_value.copyWith(
      startTimeDate: freezed == startTimeDate
          ? _value.startTimeDate
          : startTimeDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      workDescription: freezed == workDescription
          ? _value.workDescription
          : workDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePathList: null == imagePathList
          ? _value.imagePathList
          : imagePathList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectTimeEntryImplCopyWith<$Res>
    implements $ProjectTimeEntryCopyWith<$Res> {
  factory _$$ProjectTimeEntryImplCopyWith(_$ProjectTimeEntryImpl value,
          $Res Function(_$ProjectTimeEntryImpl) then) =
      __$$ProjectTimeEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? startTimeDate,
      String? workDescription,
      List<String> imagePathList});
}

/// @nodoc
class __$$ProjectTimeEntryImplCopyWithImpl<$Res>
    extends _$ProjectTimeEntryCopyWithImpl<$Res, _$ProjectTimeEntryImpl>
    implements _$$ProjectTimeEntryImplCopyWith<$Res> {
  __$$ProjectTimeEntryImplCopyWithImpl(_$ProjectTimeEntryImpl _value,
      $Res Function(_$ProjectTimeEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTimeDate = freezed,
    Object? workDescription = freezed,
    Object? imagePathList = null,
  }) {
    return _then(_$ProjectTimeEntryImpl(
      startTimeDate: freezed == startTimeDate
          ? _value.startTimeDate
          : startTimeDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      workDescription: freezed == workDescription
          ? _value.workDescription
          : workDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePathList: null == imagePathList
          ? _value._imagePathList
          : imagePathList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectTimeEntryImpl implements _ProjectTimeEntry {
  _$ProjectTimeEntryImpl(
      {this.startTimeDate,
      this.workDescription,
      final List<String> imagePathList = const []})
      : _imagePathList = imagePathList;

  factory _$ProjectTimeEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectTimeEntryImplFromJson(json);

  @override
  final DateTime? startTimeDate;
  @override
  final String? workDescription;
  final List<String> _imagePathList;
  @override
  @JsonKey()
  List<String> get imagePathList {
    if (_imagePathList is EqualUnmodifiableListView) return _imagePathList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imagePathList);
  }

  @override
  String toString() {
    return 'ProjectTimeEntry(startTimeDate: $startTimeDate, workDescription: $workDescription, imagePathList: $imagePathList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectTimeEntryImpl &&
            (identical(other.startTimeDate, startTimeDate) ||
                other.startTimeDate == startTimeDate) &&
            (identical(other.workDescription, workDescription) ||
                other.workDescription == workDescription) &&
            const DeepCollectionEquality()
                .equals(other._imagePathList, _imagePathList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, startTimeDate, workDescription,
      const DeepCollectionEquality().hash(_imagePathList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectTimeEntryImplCopyWith<_$ProjectTimeEntryImpl> get copyWith =>
      __$$ProjectTimeEntryImplCopyWithImpl<_$ProjectTimeEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectTimeEntryImplToJson(
      this,
    );
  }
}

abstract class _ProjectTimeEntry implements ProjectTimeEntry {
  factory _ProjectTimeEntry(
      {final DateTime? startTimeDate,
      final String? workDescription,
      final List<String> imagePathList}) = _$ProjectTimeEntryImpl;

  factory _ProjectTimeEntry.fromJson(Map<String, dynamic> json) =
      _$ProjectTimeEntryImpl.fromJson;

  @override
  DateTime? get startTimeDate;
  @override
  String? get workDescription;
  @override
  List<String> get imagePathList;
  @override
  @JsonKey(ignore: true)
  _$$ProjectTimeEntryImplCopyWith<_$ProjectTimeEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
