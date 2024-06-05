import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/themes/app_color.dart';
import '../../../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../../../../models/consumable_models/unit/unit.dart';
import '../../../../provider/consumeable_proivder/consumable_provider.dart';
import '../../../shared_view_widgets/symetric_button_widget.dart';

class CreateMaterialCard extends ConsumerStatefulWidget {
  final List<Unit> units;
  final Function onHideCard;
  final Duration snackbarDuration;

  const CreateMaterialCard({
    super.key,
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

  @override
  void initState() {
    super.initState();
    _units = widget.units;
    _snackbarDuration = widget.snackbarDuration;
    _consumable = ConsumableVM(amount: 0, name: '', price: 0, unit: _units.first);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _nameController.dispose();
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

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (context, constraints) => SizedBox(
            width: MediaQuery.of(context).size.width > 1000 ? 800 : constraints.maxHeight,
            // height: 350,
            child: Card(
              surfaceTintColor: Colors.white,
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            width: MediaQuery.of(context).size.width > 850
                                ? 180
                                : constraints.maxWidth / 10 * 2.3,
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
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            width: MediaQuery.of(context).size.width > 1000
                                ? 180
                                : constraints.maxWidth / 10 * 2.3,
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
                                  ),
                                  onChanged: (value) {
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
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            width: MediaQuery.of(context).size.width > 1000
                                ? 180
                                : constraints.maxWidth / 10 * 2.3,
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
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            width: MediaQuery.of(context).size.width > 1000
                                ? 180
                                : constraints.maxWidth / 10 * 2.3,
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
                                  ),
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
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12),
                          child: SymmetricButton(
                            onPressed: () {
                              _nameController.clear();
                              _amountController.clear();
                              _priceController.clear();
                              widget.onHideCard();
                            },
                            text: 'Verwerfen',
                            color: AppColor.kWhite,
                            textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColor.kPrimaryButtonColor,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12),
                          child: SymmetricButton(
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
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
}