import 'package:freezed_annotation/freezed_annotation.dart';

import '../unit/unit.dart';

part 'consumable_vm.freezed.dart';
part 'consumable_vm.g.dart';

@Freezed()
class ConsumableVM with _$ConsumableVM {
  const factory ConsumableVM({
    required int amount,
    int? id,
    required String name,
    required double price,
    Unit? unit,
  }) = _ConsumableVM;
  const ConsumableVM._();
  factory ConsumableVM.wihUnitAndJson(Map<String, dynamic> json, Unit? unit) => ConsumableVM(
        amount: json['amount'],
        id: json['id'],
        name: json['name'],
        price: json['price'],
        unit: unit,
      );

  factory ConsumableVM.fromJson(Map<String, dynamic> json) => _$ConsumableVMFromJson(json);
}
