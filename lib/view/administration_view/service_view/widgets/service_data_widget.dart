import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/service_models/service_vm/service_vm.dart';
import '../../../../provider/data_provider/service_provider/service_vm_provider.dart';

class ServiceDataWidget extends StatefulWidget {
  final ServiceVM service;

  const ServiceDataWidget({
    super.key,
    required this.service,
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
    _initialTitle = _service.name ?? '';
    _initialPrice = '${_service.hourlyRate}€';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

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
                        width: MediaQuery.of(context).size.width > 1000
                            ? 400
                            : MediaQuery.of(context).size.width / 10 * 3,
                        child: TextField(
                          controller: _titleController,
                          style: Theme.of(context).textTheme.titleMedium,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          readOnly: !isEditing,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width > 1000
                            ? 400
                            : MediaQuery.of(context).size.width / 10 * 3,
                        child: TextField(
                          style: Theme.of(context).textTheme.titleMedium,
                          controller: _priceController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          readOnly: !isEditing,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                              _priceController.text = '${value.substring(0, value.length - 1)}€';
                              _priceController.selection = TextSelection.fromPosition(
                                  TextPosition(offset: _priceController.text.length - 1));
                              return;
                            }

                            if (!value.endsWith('€')) {
                              _priceController.text = '$value€';
                              _priceController.selection = TextSelection.fromPosition(
                                  TextPosition(offset: _priceController.text.length - 1));
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
                                : () => Utilitis.askPopUp(context,
                                    message:
                                        'Sind Sie sicher, dass Sie diese Leistung löschen wollen?',
                                    onAccept: () {
                                      ref
                                          .read(serviceVMProvider.notifier)
                                          .deleteService(_service.id!)
                                          .then((e) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Center(
                                              child: Text(
                                                e
                                                    ? 'Leistung wurde erfolgreich gelöscht'
                                                    : 'Leider ist etwas schief gegangen versuchen sie es erneut',
                                              ),
                                            ),
                                          ),
                                        );

                                        Navigator.of(context).pop();
                                      });
                                    },
                                    onReject: () => Navigator.of(context).pop()),
                          ),
                          IconButton(
                            icon: Icon(isEditing ? Icons.save : Icons.edit),
                            onPressed: () {
                              if (isEditing) {
                                String priceValue = _priceController.text;

                                if (!_priceController.text.endsWith('€')) {
                                  _priceController.text += '€';
                                }
                                double parsedPrice = double.parse(priceValue.replaceAll('€', ''));

                                ServiceVM updatedRow = ServiceVM(
                                  id: widget.service.id,
                                  name: _titleController.text,
                                  hourlyRate: parsedPrice,
                                );
                                if (updatedRow != _service) {
                                  // return;
                                  ref
                                      .read(serviceVMProvider.notifier)
                                      .updateService(updatedRow)
                                      .then((e) =>
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                                    _initialPrice = '$priceValue€';
                                    isEditing = false;
                                  });
                                }
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
            ),
          ),
        ),
      );
}
