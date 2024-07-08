import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/themes/app_color.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../../../../models/consumable_models/unit/unit.dart';
import '../../../../provider/data_provider/consumeable_proivder/consumable_provider.dart';

class ConsumebaleDataRow extends ConsumerStatefulWidget {
  final ConsumableVM consumable;
  final VoidCallback onDelete;
  final List<Unit> units;
  final Duration snackbarDuration;

  const ConsumebaleDataRow({
    super.key,
    this.snackbarDuration = const Duration(seconds: 7),
    required this.consumable,
    required this.onDelete,
    required this.units,
  });

  @override
  ConsumerState<ConsumebaleDataRow> createState() => _ConsumebaleDataRowState();
}

class _ConsumebaleDataRowState extends ConsumerState<ConsumebaleDataRow> {
  bool _isSnackbarShowed = false;
  late final Duration _snackbarDuration;
  late TextEditingController _materialNameController;
  late TextEditingController _amountController;
  late TextEditingController _priceController;
  Unit? _currentUnit;
  late ConsumableVM _consumable;
  late final List<Unit> _units;
  bool isEditing = false;

  String? _initialMaterialName;
  int? _initialAmount;
  String? _initialPrice;
  Unit? _initialUnit;

  @override
  void initState() {
    super.initState();
    _consumable = widget.consumable;
    _currentUnit = _consumable.unit;
    _materialNameController = TextEditingController(text: _consumable.name);
    _amountController = TextEditingController(text: _consumable.amount.toString());
    _priceController = TextEditingController(text: '${_consumable.price}€');
    _units = widget.units;
    _snackbarDuration = widget.snackbarDuration;

    _initialMaterialName = _consumable.name;
    _initialAmount = _consumable.amount;
    _initialPrice = '${_consumable.price}€';
    _initialUnit = _consumable.unit;
  }

  @override
  void dispose() {
    _materialNameController.dispose();
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    if (_isSnackbarShowed) return;
    setState(() => _isSnackbarShowed = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(message),
        ),
        duration: _snackbarDuration,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Future.delayed(_snackbarDuration).then(
      (_) => setState(() => _isSnackbarShowed = false),
    );
  }

  bool _hasChanges() =>
      _materialNameController.text != _initialMaterialName ||
      _amountController.text != _initialAmount.toString() ||
      _priceController.text.replaceAll('€', '') != _initialPrice?.replaceAll('€', '') ||
      _currentUnit != _initialUnit;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4.0),
        child: Material(
          borderRadius: BorderRadius.circular(6),
          elevation: 3,
          child: SizedBox(
            height: 69,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
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
                          style: Theme.of(context).textTheme.titleMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isEditing ? Colors.grey[200] : Colors.transparent,
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
                          style: Theme.of(context).textTheme.titleMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isEditing ? Colors.grey[200] : Colors.transparent,
                            border: isEditing ? const OutlineInputBorder() : InputBorder.none,
                            contentPadding: const EdgeInsets.all(4),
                          ),
                          onChanged: (value) {
                            if (int.tryParse(value) == null) {
                              _amountController.text = _amountController.text
                                  .substring(0, _amountController.text.length - 1);
                              return _showSnackBar('Bitte geben sie nur Zahlen ein');
                            }

                            TextSelection previousSelection = _amountController.selection;
                            _amountController.text = value;
                            _amountController.selection = previousSelection;
                            setState(
                              () => _consumable = _consumable.copyWith(
                                amount: int.parse(_amountController.text),
                              ),
                            );
                          },
                          readOnly: !isEditing,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width > 600 ? 30 : 0),
                        width: MediaQuery.of(context).size.width > 1100
                            ? 200 - 30
                            : MediaQuery.of(context).size.width > 600
                                ? MediaQuery.of(context).size.width / 10 * 1.8 - 30
                                : MediaQuery.of(context).size.width / 10 * 1.8,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 240, 237, 237),
                            width: 1.0,
                          ),
                          color: isEditing
                              ? Colors.grey[200]
                              : const Color.fromARGB(249, 254, 255, 253),
                        ),
                        child: DropdownButton<Unit?>(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width > 1100 ? 16 : 8),
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          value: _consumable.unit,
                          items: _units
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Text(
                                        e.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(color: isEditing ? null : AppColor.kGrey),
                                      ),
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
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d*[\.\,]?\d{0,2}'))
                          ],
                          controller: _priceController,
                          style: Theme.of(context).textTheme.titleMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isEditing ? Colors.grey[200] : Colors.transparent,
                            border: isEditing ? const OutlineInputBorder() : InputBorder.none,
                            contentPadding: const EdgeInsets.all(4),
                          ),
                          readOnly: !isEditing,
                          onChanged: (value) {
                            if (value.contains(',')) {
                              final list = value.split('');
                              String newValue = '';
                              for (var e in list) {
                                if (e == ',') {
                                  newValue += '.';
                                } else {
                                  newValue += e;
                                }
                              }
                              value = newValue;
                            }

                            if (value.isNotEmpty &&
                                double.parse(value.replaceAll('€', '')) > 10000) {
                              return _showSnackBar('Diese Zahl ist zu groß');
                            }

                            TextSelection previousSelection = _priceController.selection;
                            _priceController.text = value;
                            _priceController.selection = previousSelection;
                            setState(() {
                              _consumable = _consumable.copyWith(
                                  price: double.parse(_priceController.text.replaceAll('€', '')));
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: isEditing
                              ? () {
                                  setState(() {
                                    isEditing = false;
                                    _materialNameController.text = widget.consumable.name;
                                    _amountController.text = widget.consumable.amount.toString();
                                    _priceController.text =
                                        '${widget.consumable.price}€'; // Ensure the price has € symbol
                                  });
                                }
                              : () => Utilitis.askPopUp(
                                    context,
                                    message:
                                        'Sind Sie sicher, dass Sie dieses Material löschen wollen?',
                                    onReject: () => Navigator.of(context).pop(),
                                    onAccept: () async {
                                      Navigator.of(context).pop();
                                      widget.onDelete();
                                    },
                                  ),
                          icon: Icon(isEditing ? Icons.cancel : Icons.delete),
                        ),
                        IconButton(
                          icon: Icon(
                            isEditing ? Icons.save : Icons.edit,
                          ),
                          onPressed: () {
                            if (isEditing) {
                              if (!_hasChanges()) {
                                return _showSnackBar('Keine Änderungen erkannt.');
                              }

                              String priceValue = _priceController.text;

                              if (!priceValue.endsWith('€')) {
                                priceValue += '€';
                              }

                              double parsedPrice = double.parse(priceValue.replaceAll('€', ''));

                              ConsumableVM updatedConsumable = ConsumableVM(
                                id: widget.consumable.id,
                                name: _materialNameController.text,
                                amount: int.parse(_amountController.text),
                                unit: _currentUnit ?? _consumable.unit,
                                price: parsedPrice,
                              );

                              ref
                                  .read(consumableProvider.notifier)
                                  .updateConsumable(updatedConsumable)
                                  .then((b) {
                                if (b) {
                                  // ignore: unused_result
                                  ref.refresh(consumableProvider);
                                  setState(() {
                                    _priceController.text = priceValue;
                                    isEditing = false;
                                  });
                                }

                                return _showSnackBar(
                                  b ? 'wurde erfolgreich angebpasst' : 'hat leider nicht geklappt',
                                );
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
            ),
          ),
        ),
      );
}
