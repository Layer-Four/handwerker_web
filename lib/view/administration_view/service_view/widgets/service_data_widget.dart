import 'dart:developer';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _service = widget.service;
    _priceController = TextEditingController(text: _service.hourlyRate.toString());
    _titleController = TextEditingController(text: _service.name);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
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
                                _titleController.text = _service.name;
                                _priceController.text = _service.hourlyRate.toString();
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
                          ServiceVM updatedRow = ServiceVM(
                            id: widget.service.id,
                            name: _titleController.text,
                            hourlyRate: double.tryParse(_priceController.text) ?? 0.0,
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
                              hourlyRate: double.tryParse(_priceController.text) ?? 0.0,
                              name: _titleController.text,
                            );
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
