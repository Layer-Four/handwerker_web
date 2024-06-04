import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/themes/app_color.dart';
import '../../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../../../models/consumable_models/unit/unit.dart';
import '../../../provider/consumeable_proivder/consumable_provider.dart';

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
    _materialNameController = TextEditingController(text: widget.consumable.name);
    _amountController = TextEditingController(text: widget.consumable.amount.toString());
    // currentUnitId = widget.consumable.unit.id;
    _priceController = TextEditingController(text: widget.consumable.price.toString());
    // ensureValidUnitId();
    _units = widget.units;
  }

  // void ensureValidUnitId() {
  //   if (!widget.units.any((unit) => unit.id == currentUnitId)) {
  //     currentUnitId = widget.units.isNotEmpty ? widget.units.first.id : -1;
  //   }
  // }

  @override
  void dispose() {
    _materialNameController.dispose();
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Sind Sie sicher, dass Sie dieses Objekt löschen wollen?'),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColor.kPrimaryButtonColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              widget.onDelete();
            },
            child: const Text('Ja'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColor.kPrimaryButtonColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Nein'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(bottom: 12, top: 15),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextField(
                controller: _materialNameController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                readOnly: !isEditing,
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: _amountController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                readOnly: !isEditing,
                keyboardType: TextInputType.number,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 240, 237, 237),
                      width: 1.0,
                    ),
                    color: const Color.fromARGB(249, 254, 255, 253),
                  ),
                  child: DropdownButton<Unit>(
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    value: _consumable.unit.id == -1 ? null : _consumable.unit,
                    // value: currentUnitId == -1 ? null : currentUnitId,
                    onChanged: isEditing
                        ? (newValue) {
                            setState(() {
                              _currentUnit = newValue;
                            });
                          }
                        : null,
                    items: _units
                        .map((Unit unit) => DropdownMenuItem(
                              value: unit,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(unit.name),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: _priceController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                readOnly: !isEditing,
                keyboardType: TextInputType.number,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(isEditing ? Icons.cancel : Icons.delete),
                    onPressed: isEditing
                        ? () {
                            setState(() {
                              isEditing = false;
                              _materialNameController.text = widget.consumable.name;
                              _amountController.text = widget.consumable.amount.toString();
                              // currentUnitId = widget.consumable.unit.id;
                              _priceController.text = widget.consumable.price.toString();
                              // ensureValidUnitId();
                            });
                          }
                        : _showDeleteConfirmation,
                  ),
                  IconButton(
                    icon: Icon(isEditing ? Icons.save : Icons.edit),
                    onPressed: () {
                      if (isEditing) {
                        // Ensure that the selected unit ID is correctly set

                        ConsumableVM updatedConsumable = ConsumableVM(
                          id: widget.consumable.id,
                          name: _materialNameController.text,
                          amount: int.parse(_amountController.text),
                          unit: _currentUnit ?? _consumable.unit,
                          price: int.parse(_priceController.text),
                        );
                        ref.read(consumableProvider.notifier).updateConsumable(updatedConsumable);

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
