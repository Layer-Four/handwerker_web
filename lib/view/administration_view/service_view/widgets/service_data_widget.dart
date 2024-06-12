import 'package:flutter/material.dart';
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
  late ServiceVM _servive;

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _servive = widget.service;
    _priceController = TextEditingController(text: _servive.hourlyRate.toString());
    _titleController = TextEditingController(text: _servive.name);
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
                  width: MediaQuery.of(context).size.width > 1000
                      ? 400
                      : MediaQuery.of(context).size.width / 10 * 3,
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
                  width: MediaQuery.of(context).size.width > 1000
                      ? 400
                      : MediaQuery.of(context).size.width / 10 * 3,
                  child: TextField(
                    controller: _priceController,
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
                                _titleController.text = _servive.name;
                                _priceController.text = _servive.hourlyRate.toString();
                              });
                            }
                          : () => Utilitis.askPopUp(context,
                              message: 'Sind Sie sicher, dass Sie diese Leistung löschen wollen?',
                              onAccept: () {
                                ref
                                    .read(serviceVMProvider.notifier)
                                    .deleteService(_servive.id!)
                                    .then((e) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Center(
                                    child: Text(
                                      e
                                          ? 'Leistung wurde erfolgreich gelöscht'
                                          : 'Leider ist etwas schief gegangen versuchen sie es erneut',
                                    ),
                                  )));
                                  // ignore: unused_result
                                  ref.refresh(serviceVMProvider);
                                  Navigator.of(context).pop();
                                });
                              },
                              onReject: () => Navigator.of(context).pop()),
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
                                  ))));

                          setState(() {
                            _servive = _servive.copyWith(
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
