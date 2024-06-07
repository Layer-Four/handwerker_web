import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../../../../models/consumable_models/unit/unit.dart';
import '../../../../provider/data_provider/consumeable_proivder/consumable_provider.dart';

class ConsumebaleDataRow extends ConsumerStatefulWidget {
  final ConsumableVM consumable;
  final VoidCallback onDelete;
  final List<Unit> units;

  const ConsumebaleDataRow({
    super.key,
    required this.consumable,
    required this.onDelete,
    required this.units,
  });

  @override
  ConsumerState<ConsumebaleDataRow> createState() => _ConsumebaleDataRowState();
}

class _ConsumebaleDataRowState extends ConsumerState<ConsumebaleDataRow> {
  late TextEditingController _materialNameController;
  late TextEditingController _amountController;
  late TextEditingController _priceController;
  Unit? _currentUnit;
  late ConsumableVM _consumable;
  late final List<Unit> _units;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _consumable = widget.consumable;
    _currentUnit = _consumable.unit;
    _materialNameController = TextEditingController(text: _consumable.name);
    _amountController = TextEditingController(text: _consumable.amount.toString());
    _priceController = TextEditingController(text: _consumable.price.toString());
    _units = widget.units;
  }

  @override
  void dispose() {
    _materialNameController.dispose();
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        height: 75,
        // width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width > 1100
                      ? 200
                      : MediaQuery.of(context).size.width / 10 * 1.8,
                  child: TextField(
                    controller: _materialNameController,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      border: isEditing ? const OutlineInputBorder() : InputBorder.none,
                      contentPadding: const EdgeInsets.all(4),
                    ),
                    readOnly: !isEditing,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width > 1100
                      ? 200
                      : MediaQuery.of(context).size.width / 10 * 1.8,
                  child: TextField(
                    controller: _amountController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(4),
                    ),
                    readOnly: !isEditing,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width > 1100
                      ? 200
                      : MediaQuery.of(context).size.width / 10 * 1.8,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 240, 237, 237),
                      width: 1.0,
                    ),
                    color: const Color.fromARGB(249, 254, 255, 253),
                  ),
                  child: DropdownButton<Unit?>(
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    value: _consumable.unit,
                    items: _units
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(e.name),
                              ),
                            ))
                        .toList(),
                    onChanged: isEditing
                        ? (Unit? newValue) {
                            setState(() {
                              _consumable = _consumable.copyWith(unit: newValue);
                              _currentUnit = newValue;
                            });
                          }
                        : null,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width > 1100
                      ? 200
                      : MediaQuery.of(context).size.width / 10 * 1.8,
                  child: TextField(
                    controller: _priceController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(4),
                    ),
                    readOnly: !isEditing,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 800 ? 32 : 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: isEditing
                        ? () {
                            setState(() {
                              isEditing = false;
                              _materialNameController.text = widget.consumable.name;
                              _amountController.text = widget.consumable.amount.toString();
                              _priceController.text = widget.consumable.price.toString();
                            });
                          }
                        : () => Utilitis.askPopUp(
                              context,
                              message: 'Sind Sie sicher, dass Sie dieses Material löschen wollen?',
                              onReject: () => Navigator.of(context).pop(),
                              onAccept: widget.onDelete,
                            ),
                    child: Icon(isEditing ? Icons.cancel : Icons.delete, size: 25),
                  ),
                  InkWell(
                    child: Icon(isEditing ? Icons.save : Icons.edit, size: 25),
                    onTap: () {
                      if (isEditing) {
                        ConsumableVM updatedConsumable = ConsumableVM(
                          id: widget.consumable.id,
                          name: _materialNameController.text,
                          amount: int.parse(_amountController.text),
                          unit: _currentUnit ?? _consumable.unit,
                          price: double.parse(_priceController.text),
                        );
                        ref
                            .read(consumableProvider.notifier)
                            .updateConsumable(updatedConsumable)
                            .then((b) {
                          // ignore: unused_result
                          if (b) ref.refresh(consumableProvider);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  b ? 'wurde erfolgreich angebpasst' : 'hat leider nicht geklappt',
                                ),
                              ),
                            ),
                          );
                        });
                        setState(() {
                          isEditing = false;
                        });
                      } else {
                        setState(() {
                          isEditing = true;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
