import 'package:freezed_annotation/freezed_annotation.dart';
part 'unit.freezed.dart';
part 'unit.g.dart';

// TODO: Ask DAvid is a screen for Custom Unit definition? Current version got "Gewicht" should User create Pound or Kilo Gramm oder Tons
@freezed
class Unit with _$Unit {
  const factory Unit({
    required int id,
    required String name,
  }) = _Unit;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  const Unit._();
}
