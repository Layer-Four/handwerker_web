import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/themes/app_color.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/service_models/service_vm/service_vm.dart';
import '../../../../provider/data_provider/service_provider/service_vm_provider.dart';
import '../../../shared_widgets/ask_agreement_widget.dart';
import '../../../shared_widgets/hover_textfield_widget.dart';

class ServiceDataWidget extends ConsumerStatefulWidget {
  final ServiceVM service;

  const ServiceDataWidget({super.key, required this.service});

  @override
  ConsumerState<ServiceDataWidget> createState() => _ServiceDataWidgetState();
}

class _ServiceDataWidgetState extends ConsumerState<ServiceDataWidget> {
  late final TextEditingController _titleController, _priceController;
  // Store initial values
  late String _initialTitle, _initialPrice;
  late ServiceVM _service;
  late FocusNode _titleFocusNode, _priceFocusNode;

  // Track hover state
  bool _isEditing = false, _isSnackbarShowed = false;

  // Focus nodes

  @override
  void initState() {
    super.initState();
    _service = widget.service;
    _titleController = TextEditingController(text: _service.name);
    _priceController = TextEditingController(text: '${_service.hourlyRate}€');

    // Initialize initial values
    _initialTitle = _service.name ?? '';
    _initialPrice = '${_service.hourlyRate}€';

    // Initialize focus nodes
    _titleFocusNode = FocusNode();
    _priceFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _titleFocusNode.dispose();
    _priceFocusNode.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    if (!_isSnackbarShowed) {
      setState(() => _isSnackbarShowed = true);
      Utilitis.showSnackBar(context, message);
      Future.delayed(const Duration(seconds: 7)).then(
        (_) => setState(() => _isSnackbarShowed = false),
      );
    }
  }

  void _resetFields() {
    setState(() {
      _isEditing = false;
      _titleFocusNode.unfocus();
      _priceFocusNode.unfocus();
      // Reset text fields to initial values if they have changed
      if (_titleController.text != _initialTitle) {
        _titleController.text = _initialTitle;
      }
      if (_priceController.text != _initialPrice) {
        _priceController.text = _initialPrice;
      }
    });
  }

  Color getBorderColor(bool isHovered) => isHovered ? AppColor.kPrimary : Colors.white;

  void _saveData() {
    String currentTitle = _titleController.text;
    String currentPrice = _priceController.text;

    // Check if changes were made
    if (currentTitle != _initialTitle || currentPrice != _initialPrice) {
      // Process changes and update if necessary
      double parsedPrice = double.parse(currentPrice.replaceAll('€', ''));
      ServiceVM updatedRow = ServiceVM(
        id: widget.service.id,
        name: currentTitle,
        hourlyRate: parsedPrice,
      );

      // Example: Updating serviceVMProvider
      ref.read(serviceVMProvider.notifier).updateService(updatedRow).then((e) {
        Utilitis.showSnackBar(
          context,
          e
              ? 'Leistung wurde erfolgreich geändert'
              : 'Leider hat es nicht funktioniert. Versuchen Sie es erneut.',
        );

        // Update local state
        setState(() {
          _service = _service.copyWith(
            hourlyRate: parsedPrice,
            name: currentTitle,
          );
          _initialTitle = currentTitle;
          _initialPrice = currentPrice;
        });
      });
      // No changes were made, just reset fields
    }
    _resetFields();
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
                      // Title TextField
                      HoverTextfieldWidget(
                        controller: _titleController,
                        isEdit: _isEditing,
                        onDoubleTap: () => setState(() => _isEditing = !_isEditing),
                        onTapOutside: (_) => _resetFields(),
                        onSubmitted: (_) => _isEditing ? _saveData() : null,
                        onMaxWidth: 384,
                        minWidth: 0.30,
                      ),

                      // TODO: when on Textfield clicked and edit aktiv, is one Field prevered? than that one Focusnode
                      HoverTextfieldWidget(
                        controller: _priceController,
                        isEdit: _isEditing,
                        onDoubleTap: () => setState(() => _isEditing = !_isEditing),
                        onTapOutside: (_) => _resetFields(),
                        onSubmitted: (_) => _isEditing ? _saveData() : null,
                        format: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*[\,\.]?\d{0,2}€?$')),
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
                            _priceController.text = p0.substring(0, p0.length - 1);
                            return _showSnackBar('Diese Zahl ist zu groß');
                          }

                          TextSelection previousSelection = _priceController.selection;
                          _priceController.text = p0;
                          _priceController.selection = previousSelection;
                          setState(() {
                            _service = _service.copyWith(
                                hourlyRate:
                                    double.tryParse(_priceController.text.replaceAll('€', '')));
                          });
                        },
                        // onChanged: (value) {
                        //   if (value.contains(',')) {
                        //     final list = value.split('');
                        //     String newValue = '';
                        //     for (var i in list) {
                        //       if (i == ',') {
                        //         newValue += '.';
                        //       } else if (i == '€') {
                        //       } else {
                        //         newValue += i;
                        //       }
                        //     }
                        //     value = newValue;
                        //   }

                        //   if (double.parse(value.replaceAll('€', '')) > 100000) {
                        //     _showSnackBar('Diese Zahl ist zu groß');
                        //     _priceController.text = '${value.substring(0, value.length - 1)}€';
                        //     _priceController.selection = TextSelection.fromPosition(
                        //       TextPosition(offset: _priceController.text.length - 1),
                        //     );
                        //     return;
                        //   }

                        //   if (!value.endsWith('€')) {
                        //     _priceController.text = '$value€';
                        //     _priceController.selection = TextSelection.fromPosition(
                        //       TextPosition(offset: _priceController.text.length - 1),
                        //     );
                        //   }
                        // },
                      ),
                    ],
                  ),
                  // Edit and Delete Icons
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Cancel or Delete Icon
                        IconButton(
                            icon: Icon(_isEditing ? Icons.cancel : Icons.delete),
                            onPressed: _isEditing
                                ? () {
                                    _resetFields();
                                  }
                                : () => showDialog(
                                      context: context,
                                      builder: (context) => AskoForAgreement(
                                          message:
                                              'Sind Sie sicher, dass Sie diese Leistung löschen wollen?',
                                          onAccept: () => acceptDelete()),
                                    )),
                        // Save or Edit Icon
                        IconButton(
                          icon: Icon(_isEditing ? Icons.save : Icons.edit),
                          onPressed: () {
                            if (_isEditing) {
                              _saveData();
                            } else {
                              // Edit button pressed
                              setState(() {
                                _isEditing = true;
                                _titleFocusNode.requestFocus();
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void acceptDelete() {
    ref.read(serviceVMProvider.notifier).deleteService(_service.id!).then((e) {
      Utilitis.showSnackBar(
        context,
        e
            ? 'Leistung wurde erfolgreich gelöscht'
            : 'Leider ist etwas schief gegangen. Versuchen Sie es erneut.',
      );
      Navigator.of(context).pop();
    });
  }
}
