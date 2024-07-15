import 'package:freezed_annotation/freezed_annotation.dart';
part 'project_consumable.freezed.dart';
part 'project_consumable.g.dart';

@freezed
class ProjectConsumable with _$ProjectConsumable {
  const factory ProjectConsumable({
    required String consumableName,
    // TODO: Update when Consumable List in CustomerProjectReoports get amount
    int? consumableAmount,
    required double consumablePrice,
  }) = _ProjectConsumable;
  factory ProjectConsumable.fromJson(Map<String, dynamic> json) =>
      _$ProjectConsumableFromJson(json);
}
