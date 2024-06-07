import 'package:flutter/material.dart';

import '../../../../models/service_models/service_vm/service_vm.dart';

class ServiceDataWidget extends StatefulWidget {
  final VoidCallback onDelete;
  final Function(ServiceVM) onUpdate;
  final ServiceVM service;

  const ServiceDataWidget({
    super.key,
    required this.onDelete,
    required this.onUpdate,
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

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Dialog(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.3,
          child: AlertDialog(
            title: const Text('Sind Sie sicher, dass Sie dieses Objekt löschen wollen?'),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.orange,
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
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Nein'),
              ),
            ],
          ),
        ),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                maxLines: null,
                controller: _titleController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                readOnly: !isEditing,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
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
            const Spacer(),
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
                  : _showDeleteConfirmation,
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

                  widget.onUpdate(updatedRow);

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
      );
}
