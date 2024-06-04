import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/consumable_models/unit/unit.dart';
import '../../../provider/consumeable_proivder/consumable_provider.dart';

class CardWidget extends ConsumerStatefulWidget {
  final Function(String material, int amount, Unit unit, int price) onSave;
  final Function onHideCard;

  const CardWidget({required this.onSave, required this.onHideCard, super.key});

  @override
  ConsumerState<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends ConsumerState<CardWidget> {
  final TextEditingController _materialController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool _isLoading = false;
  bool _isFetchingUnits = true;
  final List<Unit> _units = [];
  Unit? _selectedUnit;
  String _amountError = '';
  String _priceError = '';

  @override
  void initState() {
    super.initState();
    _loadUnits();
  }

  @override
  void dispose() {
    _materialController.dispose();
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _loadUnits() {
    setState(() => _isLoading = true);
    ref.read(consumableProvider.notifier).loadUnits().then((value) {
      setState(() {
        _units.addAll(value);
        _isFetchingUnits = false;
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _isFetchingUnits = false;
        _isLoading = false;
      });
      log('Error loading units: $error');
    });
  }

  bool _validateInputs() {
    setState(() {
      _amountError = '';
      _priceError = '';
    });

    bool isValid = true;

    if (_materialController.text.isEmpty ||
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

  void _createService() async {
    final String material = _materialController.text.trim();
    final int amount = int.parse(_amountController.text.trim());
    final Unit unit = _selectedUnit!;
    final int price = int.parse(_priceController.text.trim());

    if (!_validateInputs()) {
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      await ref.read(consumableProvider.notifier).createService(material, amount, unit, price).then((value) {
        setState(() {
          _priceController.clear();
          _selectedUnit = null;
          _amountController.clear();
          _materialController.clear();
        });
      });

      widget.onSave(material, amount, unit, price);

      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      log('Error on createService: $e');
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Fehler beim Speichern'),
          content: Text('Ein Fehler ist aufgetreten: $e'),
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
    } finally {
      setState(() {
        _isLoading = false; // Stop loading after the API call completes
      });
    }
  }

  @override
  Widget build(BuildContext context) => _isLoading
      ? const Center(child: CircularProgressIndicator()) // Show loading indicator
      : _isFetchingUnits
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator for units
          : SizedBox(
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Material',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      TextField(
                                        controller: _materialController,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                      const SizedBox(height: 15),
                                      TextField(
                                        controller: _amountController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color.fromARGB(211, 245, 241, 241),
                                          hintText: 'Amount',
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Einheit', style: TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                      const SizedBox(height: 15),
                                      DropdownButton<Unit>(
                                        isExpanded: true,
                                        value: _selectedUnit,
                                        hint: const Text('Einheit'),
                                        items: _units
                                            .map((Unit unit) => DropdownMenuItem<Unit>(
                                                  value: unit,
                                                  child: Text(unit.name),
                                                ))
                                            .toList(),
                                        onChanged: (Unit? newValue) {
                                          setState(() => _selectedUnit = newValue);
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                      const SizedBox(height: 15),
                                      TextField(
                                        controller: _priceController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color.fromARGB(211, 245, 241, 241),
                                          hintText: 'Price',
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
                              TextButton(
                                onPressed: () {
                                  _materialController.clear();
                                  _amountController.clear();
                                  _priceController.clear();
                                  widget.onHideCard();
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(color: Color.fromARGB(255, 231, 226, 226), width: 1.0),
                                  ),
                                ),
                                child: const Text(
                                  'Verwerfen',
                                  style: TextStyle(color: Colors.orange),
                                ),
                              ),
                              const SizedBox(width: 10),
                              TextButton(
                                onPressed: () {
                                  if (_validateInputs()) {
                                    _createService();
                                  }
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(color: Color.fromARGB(255, 231, 226, 226), width: 1.0),
                                  ),
                                ),
                                child: const Text(
                                  'Speichern',
                                  style: TextStyle(color: Colors.white),
                                ),
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
