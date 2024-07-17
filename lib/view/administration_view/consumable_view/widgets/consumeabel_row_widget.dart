import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/themes/app_color.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../../../../models/consumable_models/unit/unit.dart';
import '../../../../provider/data_provider/consumeable_proivder/consumable_provider.dart';
import '../../../shared_widgets/ask_agreement_widget.dart';
import '../../../shared_widgets/custom_dropdown_button.dart';
import '../../../shared_widgets/hover_textfield_widget.dart';

class ConsumebaleDataRow extends ConsumerStatefulWidget {
  final ConsumableVM consumable;
  final List<Unit> units;

  const ConsumebaleDataRow({super.key, required this.consumable, required this.units});

  @override
  ConsumerState<ConsumebaleDataRow> createState() => _ConsumebaleDataRowState();
}

class _ConsumebaleDataRowState extends ConsumerState<ConsumebaleDataRow> {
  bool _isSnackbarShowed = false;
  late final TextEditingController _titleController, _amountController, _priceController;
  Unit? _currentUnit;
  late ConsumableVM _consumable;
  bool _isEditing = false;
  // Store initial values
  late String _initialAmount, _initialPrice, _initialTitle;
  late Unit? _initialUnit;

  // Track hover state
  bool _isUnitHovered = false;

  // Focus nodes

  @override
  void initState() {
    super.initState();
    _consumable = widget.consumable;
    _currentUnit = _consumable.unit;
    _titleController = TextEditingController(text: _consumable.name);
    _amountController = TextEditingController(text: _consumable.amount.toString());
    _priceController = TextEditingController(text: '${_consumable.price}€');

    _initialTitle = _consumable.name;
    _initialAmount = _consumable.amount.toStringAsFixed(0);
    _initialPrice = '${_consumable.price}€';
    _initialUnit = _consumable.unit;

    // Initialize initial values
    _initialTitle = _consumable.name;
    _initialPrice = '${_consumable.price}€';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, [Function()? callback]) {
    if (!_isSnackbarShowed) {
      setState(() => _isSnackbarShowed = true);
      Utilitis.showSnackBar(context, message);
      Future.delayed(const Duration(seconds: 7)).then((_) {
        setState(() => _isSnackbarShowed = false);
        callback;
      });
      return;
    }
    return;
  }

  void _resetFields() => setState(() {
        _isEditing = false;
        // Reset text fields to initial values if they have changed
        if (_titleController.text != _initialTitle) _titleController.text = _initialTitle;
        // Reset text fields to initial values if they have changed
        if (_priceController.text != _initialPrice) _priceController.text = _initialPrice;
      });

  bool _hasChanges() =>
      _amountController.text != _initialAmount ||
      _currentUnit != _initialUnit ||
      _priceController.text.replaceAll('€', '') != _initialPrice.replaceAll('€', '') ||
      _titleController.text != _initialTitle;

  void _saveData() {
    if (_hasChanges()) {
      final parsedPrice = double.parse(_priceController.text.replaceAll('€', ''));
      final parsedAmount = int.parse(_amountController.text.replaceAll('€', ''));
      ConsumableVM updatedConsumable = ConsumableVM(
        id: widget.consumable.id,
        name: _titleController.text,
        price: parsedPrice,
        amount: parsedAmount,
        unit: _currentUnit,
      );
      // Update local state
      setState(() {
        _consumable = _consumable.copyWith(
          price: parsedPrice,
          name: _titleController.text,
          amount: parsedAmount,
          unit: _currentUnit,
        );
        _initialTitle = _consumable.name;
        _initialPrice = '${_consumable.price}€';
        _initialUnit = _consumable.unit;
        _initialAmount = _consumable.amount.toStringAsFixed(0);
      });

      // Example: Updating serviceVMProvider
      ref.read(consumableProvider.notifier).updateConsumable(updatedConsumable).then((e) {
        Utilitis.showSnackBar(
          context,
          e
              ? 'Material wurde erfolgreich geändert'
              : 'Leider hat es nicht funktioniert. Versuchen Sie es erneut.',
        );
      });
      //  TODO: Check if resets field also after update Consumable
      // No changes were made, just reset fields
      _resetFields();
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4.0),
        child: Material(
          borderRadius: BorderRadius.circular(6),
          elevation: 3,
          child: SizedBox(
            height: 69,
            child: Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      HoverTextfieldWidget(
                        controller: _titleController,
                        isEdit: _isEditing,
                        onTapOutside: (p0) => _resetFields(),
                        onSubmitted: (p0) => _isEditing ? _saveData() : null,
                        onDoubleTap: () => setState(() => _isEditing = !_isEditing),
                      ),
                      HoverTextfieldWidget(
                        controller: _amountController,
                        isEdit: _isEditing,
                        keyboardType: TextInputType.number,
                        onTapOutside: (p0) => _resetFields(),
                        onSubmitted: (p0) => _isEditing ? _saveData() : null,
                        onDoubleTap: () => setState(() => _isEditing = !_isEditing),
                        format: [FilteringTextInputFormatter.allow(RegExp(r'^\d*'))],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onDoubleTap: () => setState(() => _isEditing = !_isEditing),
                          child: MouseRegion(
                            onEnter: (event) => setState(() => _isUnitHovered = true),
                            onExit: (event) => setState(() => _isUnitHovered = false),
                            child: CustomDropDown<Unit>(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 240, 237, 237),
                                  ),
                                  color: _isEditing
                                      ? Colors.grey[200]
                                      : const Color.fromARGB(249, 254, 255, 253),
                                ),
                                borderColor:
                                    _isUnitHovered ? AppColor.kPrimaryButtonColor : AppColor.kWhite,
                                width: MediaQuery.of(context).size.width > 1100
                                    ? 184
                                    : ((MediaQuery.of(context).size.width * 0.18) - 16),
                                initalValue: _consumable.unit,
                                items: widget.units
                                    .map(
                                      (e) => DropdownMenuItem<Unit>(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                          child: Text(
                                            e.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    color: _isEditing ? null : AppColor.kGrey),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: _isEditing
                                    ? (e) => setState(
                                          () {
                                            _consumable = _consumable.copyWith(unit: e);
                                            _currentUnit = e;
                                          },
                                        )
                                    : null),
                          ),
                        ),
                      ),
                      HoverTextfieldWidget(
                        controller: _priceController,
                        isEdit: _isEditing,
                        keyboardType: TextInputType.number,
                        onTapOutside: (p0) => _resetFields(),
                        onSubmitted: (p0) => _isEditing ? _saveData() : null,
                        onDoubleTap: () => setState(() => _isEditing = !_isEditing),
                        format: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*[\.\,]?\d{0,2}')),
                        ],
                        onChanged: (p0) {
                          if (p0.contains(',')) {
                            final list = p0.split('');
                            String newValue = '';
                            for (var e in list) {
                              if (e == ',') {
                                newValue += '.';
                              } else {
                                newValue += e;
                              }
                            }
                            p0 = newValue;
                          }

                          if (p0.isNotEmpty && double.parse(p0.replaceAll('€', '')) > 100000) {
                            return _showSnackBar('Diese Zahl ist zu groß');
                          }

                          TextSelection previousSelection = _priceController.selection;
                          _priceController.text = p0;
                          _priceController.selection = previousSelection;
                          setState(() {
                            _consumable = _consumable.copyWith(
                                price: double.parse(_priceController.text.replaceAll('€', '')));
                          });
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: _isEditing
                              ? () => _resetFields()
                              : () => showDialog(
                                    context: context,
                                    builder: (context) => AskoForAgreement(
                                      message:
                                          'Sind Sie sicher, dass Sie dieses Material löschen wollen?',
                                      onAccept: () {
                                        ref
                                            .read(consumableProvider.notifier)
                                            .deleteConsumable(_consumable.id!)
                                            .then((e) {
                                          _showSnackBar(e
                                              ? 'Eintrag erfolgreich gelöscht'
                                              : 'Es ist ein Fehler aufgetreten während dem Löschen');
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                  ),
                          icon: Icon(_isEditing ? Icons.cancel : Icons.delete),
                        ),
                        IconButton(
                          icon: Icon(
                            _isEditing ? Icons.save : Icons.edit,
                          ),
                          onPressed: () {
                            if (_isEditing) {
                              if (!_hasChanges()) {
                                setState(() => _isEditing = !_isEditing);
                                return _showSnackBar('Keine Änderungen erkannt.');
                              }

                              String priceValue = _priceController.text;

                              if (!priceValue.endsWith('€')) {
                                priceValue += '€';
                              }

                              double parsedPrice = double.parse(priceValue.replaceAll('€', ''));

                              ConsumableVM updatedConsumable = ConsumableVM(
                                id: widget.consumable.id,
                                name: _titleController.text,
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
                                  });
                                }

                                return _showSnackBar(
                                  b ? 'wurde erfolgreich angebpasst' : 'hat leider nicht geklappt',
                                );
                              });
                            }
                            setState(() {
                              _isEditing = true;
                            });
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
