import 'package:freezed_annotation/freezed_annotation.dart';

part 'consumable_dm.freezed.dart';
part 'consumable_dm.g.dart';

@freezed
class ConsumableDM with _$ConsumableDM {
  const factory ConsumableDM({
    @Default(1) double amount,
    int? id,
    required int materialUnitID,
    String? name,
    String? materialID,
    double? netPrice,
    double? grossPrice,
    double? vat,
    required String materialUnitName,
  }) = _ConsumableDM;
  factory ConsumableDM.fromJson(Map<String, dynamic> json) => _$ConsumableDMFromJson(json);
}
