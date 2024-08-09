import 'package:freezed_annotation/freezed_annotation.dart';

import '../consumable_dm/consumable_dm.dart';
import '../unit/unit.dart';

part 'consumable_vm.freezed.dart';
part 'consumable_vm.g.dart';

@freezed
class ConsumableVM with _$ConsumableVM {
  const factory ConsumableVM({
    required double amount,
    String? id,
    required String name,
    required double netPrice,
    double? grossPrice,
    double? vat,
    Unit? unit,
  }) = _ConsumableVM;
  const ConsumableVM._();
  factory ConsumableVM.wihUnitAndJson(ConsumableDM e, Unit? unit) => ConsumableVM(
        amount: e.amount,
        id: e.materialID,
        name: e.name!,
        netPrice: e.netPrice!,
        grossPrice: e.grossPrice,
        vat: e.vat,
        unit: unit,
      );

  factory ConsumableVM.fromJson(Map<String, dynamic> json) => _$ConsumableVMFromJson(json);
}
