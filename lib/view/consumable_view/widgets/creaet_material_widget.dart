import 'dart:developer' as log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../../../models/consumable_models/unit/unit.dart';
import '../../../provider/consumeable_proivder/consumable_provider.dart';
import '../../shared_view_widgets/symetric_button_widget.dart';

class CreateMaterialCard extends ConsumerStatefulWidget {
  final Function()? onAccept;
  final Function(String material, int amount, Unit unit, int price) onSave;
  final List<Unit> units;
  final Function onHideCard;
  final Duration snackbarDuration;

  const CreateMaterialCard({
    super.key,
    required this.onAccept,
    required this.onSave,
    required this.onHideCard,
    required this.units,
    this.snackbarDuration = const Duration(seconds: 7),
  });

  @override
  ConsumerState<CreateMaterialCard> createState() => _CreateMaterialCardState();
}

class _CreateMaterialCardState extends ConsumerState<CreateMaterialCard> {
  bool _isSnackbarShowed = false;
  late final Duration _snackbarDuration;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  late final List<Unit> _units;
  Unit? _selectedUnit;
  late ConsumableVM _consumable;
  String _amountError = '';
  String _priceError = '';

  @override
  void initState() {
    super.initState();
    _units = widget.units;
    _snackbarDuration = widget.snackbarDuration;
    _consumable = ConsumableVM(amount: 0, name: '', price: 0, unit: _units.first);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    if (_isSnackbarShowed) return;
    setState(() => _isSnackbarShowed = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: _snackbarDuration),
    );
    Future.delayed(_snackbarDuration).then(
      (_) => setState(() => _isSnackbarShowed = false),
    );
  }

  bool _validateInputs() {
    setState(() {
      _amountError = '';
      _priceError = '';
    });

    bool isValid = true;

    if (_nameController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectedUnit == null ||
        _priceController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Fehler'),
          content: const Text('Alle Felder müssen ausgefüllt sein!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
      isValid = false;
    }

    if (int.tryParse(_amountController.text) == null) {
      setState(() {
        _amountError = 'Bitte eine Zahl eingeben';
      });
      isValid = false;
    }

    if (int.tryParse(_priceController.text) == null) {
      setState(() {
        _priceError = 'Bitte eine Zahl eingeben';
      });
      isValid = false;
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.maxFinite,
        height: 350,
        child: Card(
          surfaceTintColor: Colors.white,
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Material', style: Theme.of(context).textTheme.labelLarge),
                                const SizedBox(height: 15),
                                TextField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(211, 245, 241, 241),
                                    hintText: 'Material',
                                    contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.grey, width: 0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    TextSelection previousSelection = _nameController.selection;
                                    _nameController.text = value;
                                    _nameController.selection = previousSelection;
                                    setState(() => _consumable =
                                        _consumable.copyWith(name: _nameController.text));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Menge', style: Theme.of(context).textTheme.labelLarge),
                                const SizedBox(height: 15),
                                TextField(
                                  controller: _amountController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(211, 245, 241, 241),
                                    hintText: 'Menge',
                                    contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.grey, width: 0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorText: _amountError.isEmpty ? null : _amountError,
                                  ),
                                  onChanged: (value) {
                                    log.log(value);
                                    if (int.tryParse(value) == null) {
                                      _amountController.text = _amountController.text
                                          .substring(0, _amountController.text.length - 1);
                                      return _showSnackBar('Bitte geben sie nur Zahlen ein');
                                    }
                                    if (int.parse(value) > 10000) {
                                      // TODO:Check max size of Decimal and react to it.
                                      return _showSnackBar('Diese Zahl ist zu groß');
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
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Einheit', style: Theme.of(context).textTheme.labelLarge),
                                const SizedBox(height: 15),
                                DropdownButton<Unit>(
                                  isExpanded: true,
                                  value: _selectedUnit,
                                  // hint: const Text('Einheit'),
                                  items: _units
                                      .map((Unit unit) => DropdownMenuItem<Unit>(
                                            value: unit,
                                            child: Text(unit.name),
                                          ))
                                      .toList(),
                                  onChanged: (Unit? newValue) {
                                    setState(() {
                                      _consumable = _consumable.copyWith(unit: newValue!);
                                      _selectedUnit = newValue;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Preis', style: Theme.of(context).textTheme.labelLarge),
                                const SizedBox(height: 15),
                                TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d*[\.\,]?\d{0,2}'))
                                  ],
                                  keyboardType: TextInputType.number,
                                  controller: _priceController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(211, 245, 241, 241),
                                    hintText: 'Preis/€',
                                    contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.grey, width: 0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorText: _priceError.isEmpty ? null : _priceError,
                                  ),
                                  onChanged: (value) {
                                    log.log(value);

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

                                    if (double.parse(value) > 10000) {
                                      // TODO:Check max size of Decimal and react to it.
                                      return _showSnackBar('Diese Zahl ist zu groß');
                                    }
                                    TextSelection previousSelection = _priceController.selection;
                                    _priceController.text = value;
                                    _priceController.selection = previousSelection;
                                    setState(() {
                                      _consumable = _consumable.copyWith(
                                          price: double.parse(_priceController.text));
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SymmetricButton(
                          onPressed: () {
                            _nameController.clear();
                            _amountController.clear();
                            _priceController.clear();
                            widget.onHideCard();
                          },
                          textStyle: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 231, 226, 226), width: 1.0),
                            ),
                          ),
                          text: 'Verwerfen',
                          // style: TextStyle(color: Colors.orange),
                        ),
                        const SizedBox(width: 10),
                        SymmetricButton(
                          text: 'Speichern',
                          onPressed: () {
                            if (_nameController.text.isNotEmpty ||
                                _amountController.text.isNotEmpty ||
                                _selectedUnit != null ||
                                _priceController.text.isNotEmpty) {
                              ref
                                  .read(consumableProvider.notifier)
                                  .createConsumable(_consumable)
                                  .then((e) {
                                e
                                    ? {
                                        ref.refresh(consumableProvider),
                                        _nameController.clear(),
                                        _amountController.clear(),
                                        _priceController.clear(),
                                      }
                                    : _showSnackBar('hat nicht geklappt');
                              });
                            }
                            // _materialController.text,
                            // int.tryParse(_), Unit unit, double price
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

// class DecimalTextInputFormatter extends TextInputFormatter {
//   final int decimalRange;
//   DecimalTextInputFormatter({
//     required this.decimalRange,
//   }) : assert(decimalRange > 0);

//   get math => null;

//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue, // unused.
//     TextEditingValue newValue,
//   ) {
//     TextSelection newSelection = newValue.selection;
//     String truncated = newValue.text;

//     String value = newValue.text;

//     if (value.contains('.') && value.substring(value.indexOf('.') + 1).length > decimalRange) {
//       truncated = oldValue.text;
//       newSelection = oldValue.selection;
//     } else if (value == '.') {
//       truncated = '0.';

//       newSelection = newValue.selection.copyWith(
//         baseOffset: math.min(truncated.length, truncated.length + 1),
//         extentOffset: math.min(truncated.length, truncated.length + 1),
//       );
//     }

//     return TextEditingValue(
//       text: truncated,
//       selection: newSelection,
//       composing: TextRange.empty,
//     );
//     return newValue;
//   }
// }
