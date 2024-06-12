import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/service_models/service_vm/service_vm.dart';
import '../../../../provider/data_provider/service_provider/service_vm_provider.dart';

class ServiceDataWidget extends StatefulWidget {
  final ServiceVM service;
  final VoidCallback onDelete;

  const ServiceDataWidget({
    super.key,
    required this.service,
    required this.onDelete,
  });

  @override
  State<ServiceDataWidget> createState() => _ServiceDataWidgetState();
}

class _ServiceDataWidgetState extends State<ServiceDataWidget> {
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late ServiceVM _service;

  bool isEditing = false;

  // Store initial values
  late String _initialTitle;
  late String _initialPrice;

  @override
  void initState() {
    super.initState();
    _service = widget.service;
    _titleController = TextEditingController(text: _service.name);
    _priceController = TextEditingController(text: '${_service.hourlyRate}€');

    // Initialize initial values
    _initialTitle = _service.name;
    _initialPrice = '${_service.hourlyRate}€';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  bool _hasChanges() => _titleController.text != _initialTitle || _priceController.text != _initialPrice;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(message),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Container(
        height: 75,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width > 1000 ? 300 : MediaQuery.of(context).size.width / 10 * 3,
                  child: TextField(
                    controller: _titleController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    readOnly: !isEditing,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width > 1000 ? 300 : MediaQuery.of(context).size.width / 10 * 3,
                  child: TextField(
                    controller: _priceController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    readOnly: !isEditing,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}€?$')),
                    ],
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

                      if (double.tryParse(value.replaceAll('€', '')) != null &&
                          double.parse(value.replaceAll('€', '')) > 10000) {
                        _showSnackBar('Diese Zahl ist zu groß');
                        _priceController.text = value.substring(0, value.length - 1) + '€';
                        _priceController.selection =
                            TextSelection.fromPosition(TextPosition(offset: _priceController.text.length - 1));
                        return;
                      }

                      if (!value.endsWith('€')) {
                        _priceController.text = value + '€';
                        _priceController.selection =
                            TextSelection.fromPosition(TextPosition(offset: _priceController.text.length - 1));
                      }
                    },
                  ),
                ),
              ],
            ),
            Consumer(
              builder: (context, ref, child) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(isEditing ? Icons.cancel : Icons.delete),
                      onPressed: isEditing
                          ? () {
                              setState(() {
                                isEditing = false;
                                _titleController.text = _initialTitle;
                                _priceController.text = _initialPrice;
                              });
                            }
                          : () {
                              log('Deleting service with ID: ${_service.id}');
                              Utilitis.askPopUp(
                                context,
                                message: 'Sind Sie sicher, dass Sie diese Leistung löschen wollen?',
                                onAccept: () async {
                                  Navigator.of(context).pop(); // Close the dialog
                                  widget.onDelete();
                                },
                                onReject: () => Navigator.of(context).pop(),
                              );
                            },
                    ),
                    IconButton(
                      icon: Icon(isEditing ? Icons.save : Icons.edit),
                      onPressed: () {
                        if (isEditing) {
                          if (!_hasChanges()) {
                            _showSnackBar('Keine Änderungen erkannt.');
                            return;
                          }
                          String priceValue = _priceController.text;

                          // Ensure the Euro symbol is present before sending to the server
                          if (!priceValue.endsWith('€')) {
                            priceValue += '€';
                          }
                          double parsedPrice = double.parse(priceValue.replaceAll('€', ''));

                          ServiceVM updatedRow = ServiceVM(
                            id: widget.service.id,
                            name: _titleController.text,
                            hourlyRate: parsedPrice,
                          );
                          ref
                              .read(serviceVMProvider.notifier)
                              .updateService(updatedRow)
                              .then((e) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Center(
                                      child: Text(
                                        e
                                            ? 'Leistung wurde erfolgreich geändert'
                                            : 'Leider hat es nicht Funktioniert\nversuche es erneut',
                                      ),
                                    ),
                                  )));

                          setState(() {
                            _service = _service.copyWith(
                              hourlyRate: parsedPrice,
                              name: _titleController.text,
                            );
                            // Update initial values to the new values after save
                            _initialTitle = _titleController.text;
                            _initialPrice = priceValue;
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
            ),
          ],
        ),
      );
}
