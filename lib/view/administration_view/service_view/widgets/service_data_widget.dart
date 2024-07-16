import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/themes/app_color.dart';
import '../../../../models/service_models/service_vm/service_vm.dart';
import '../../../../provider/data_provider/service_provider/service_vm_provider.dart';
import '../../../shared_widgets/ask_agreement_widget.dart';

class ServiceDataWidget extends ConsumerStatefulWidget {
  final ServiceVM service;

  const ServiceDataWidget({
    super.key,
    required this.service,
  });

  @override
  ConsumerState<ServiceDataWidget> createState() => _ServiceDataWidgetState();
}

class _ServiceDataWidgetState extends ConsumerState<ServiceDataWidget> {
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late ServiceVM _service;
  bool isEditing = false;

  // Store initial values
  late String _initialTitle;
  late String _initialPrice;

  // Track hover state
  bool _isTitleHovered = false;
  bool _isPriceHovered = false;

  // Focus nodes
  late FocusNode _titleFocusNode;
  late FocusNode _priceFocusNode;

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(message),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _resetFields() {
    setState(() {
      isEditing = false;
      // Reset text fields to initial values if they have changed
      if (_titleController.text != _initialTitle) {
        _titleController.text = _initialTitle;
      }
      if (_priceController.text != _initialPrice) {
        _priceController.text = _initialPrice;
      }
      _titleFocusNode.unfocus();
      _priceFocusNode.unfocus();
    });
  }

  Color getBorderColor(bool isHovered) =>
      isHovered ? AppColor.kPrimary : Colors.white.withOpacity(0.5);

  void _saveData(WidgetRef ref) {
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(
                e
                    ? 'Leistung wurde erfolgreich geändert'
                    : 'Leider hat es nicht funktioniert. Versuchen Sie es erneut.',
              ),
            ),
          ),
        );

        // Update local state
        setState(() {
          _service = _service.copyWith(
            hourlyRate: parsedPrice,
            name: currentTitle,
          );
          _initialTitle = currentTitle;
          _initialPrice = '$currentPrice€';
          _resetFields(); // Reset fields after saving
        });
      });
    } else {
      // No changes were made, show a snack bar message
      _showSnackBar('Keine Änderung wurde erkannt');
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
                      // Title TextField
                      SizedBox(
                        width: MediaQuery.of(context).size.width > 1000
                            ? 400
                            : MediaQuery.of(context).size.width / 10 * 3,
                        child: MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              _isTitleHovered = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              _isTitleHovered = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isEditing ? Colors.grey[200] : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color:
                                    isEditing ? AppColor.kPrimary : getBorderColor(_isTitleHovered),
                              ),
                            ),
                            child: TextField(
                              controller: _titleController,
                              focusNode: _titleFocusNode,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                  ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                              ),
                              readOnly: !isEditing,
                              onTap: () {
                                setState(() {
                                  _titleFocusNode.requestFocus();
                                });
                              },
                              onSubmitted: (value) {
                                if (isEditing) {
                                  _saveData(ref);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      // Price TextField
                      SizedBox(
                        width: MediaQuery.of(context).size.width > 1000
                            ? 400
                            : MediaQuery.of(context).size.width / 10 * 3,
                        child: MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              _isPriceHovered = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              _isPriceHovered = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isEditing ? Colors.grey[200] : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color:
                                    isEditing ? AppColor.kPrimary : getBorderColor(_isPriceHovered),
                              ),
                            ),
                            child: TextField(
                              controller: _priceController,
                              focusNode: _priceFocusNode,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                  ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                              ),
                              readOnly: !isEditing,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}€?$')),
                              ],
                              onTap: () {
                                setState(() {
                                  _priceFocusNode.requestFocus();
                                });
                              },
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
                                  _priceController.text =
                                      '${value.substring(0, value.length - 1)}€';
                                  _priceController.selection = TextSelection.fromPosition(
                                    TextPosition(offset: _priceController.text.length - 1),
                                  );
                                  return;
                                }

                                  if (!value.endsWith('€')) {
                                    _priceController.text = '$value€';
                                    _priceController.selection = TextSelection.fromPosition(
                                        TextPosition(offset: _priceController.text.length - 1));
                                  }
                                },
                                onSubmitted: (value) {
                                  if (isEditing) {
                                    _saveData(ref);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Edit and Delete Icons
                  Consumer(
                    builder: (context, ref, child) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Cancel or Delete Icon
                          IconButton(
                              icon: Icon(isEditing ? Icons.cancel : Icons.delete),
                              onPressed: isEditing
                                  ? () {
                                      _resetFields();
                                    }
                                  : () => showDialog(
                                        context: context,
                                        builder: (context) => AskoForAgreement(
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
                                                          : 'Leider ist etwas schief gegangen. Versuchen Sie es erneut.',
                                                    ),
                                                  ),
                                                ),
                                              );
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                      )),
                          // Save or Edit Icon
                          IconButton(
                            icon: Icon(isEditing ? Icons.save : Icons.edit),
                            onPressed: () {
                              if (isEditing) {
                                _saveData(ref);
                              } else {
                                // Edit button pressed
                                setState(() {
                                  isEditing = true;
                                  _titleFocusNode.requestFocus();
                                });
                              }
                            },
                          )
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
