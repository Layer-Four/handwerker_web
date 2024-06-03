import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/api/api.dart';
import '../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../../models/consumable_models/unit/unit.dart';
import '../../provider/consumeable_proivder/consumable_provider.dart';
import '../shared_view_widgets/search_line_header.dart';
import 'widgets/card_widget.dart';

class ConsumableBody extends ConsumerStatefulWidget {
  const ConsumableBody({super.key});

  @override
  ConsumerState<ConsumableBody> createState() => _ConsumableBodyState();
}

class _ConsumableBodyState extends ConsumerState<ConsumableBody> {
  List<Unit> _units = [];
  List<ConsumableVM> rowDataList = [];
  final Api _api = Api();
  bool isLoading = true;
  bool isCardVisible = false;

  @override
  void initState() {
    super.initState();
    loadUnits();
  }

  void loadUnits() {
    setState(() => isLoading = true);
    ref.read(consumableProvider.notifier).loadUnits().then((value) {
      setState(() {
        _units.addAll(value);
        loadMaterialList();
      });
    });
  }

  void loadMaterialList() {
    ref.read(consumableProvider.notifier).loadConsumables().then((_) {
      setState(() {
        rowDataList = ref.read(consumableProvider);
        isLoading = false;
      });
    });
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void hideCard() {
    setState(() {
      isCardVisible = false;
    });
  }

  void deleteService(ConsumableVM row) async {
    try {
      await ref.read(consumableProvider.notifier).deleteConsumable(row.id);
      setState(() {
        rowDataList = ref.read(consumableProvider); // Update the local list to reflect the deletion
      });
      _showSnackBar('Row deleted successfully.');
    } catch (e) {
      _showSnackBar('Error when attempting to delete the item: $e');
    }
  }

  Future<void> updateRow(ConsumableVM row) async {
    try {
      final data = row.toJson();
      log('Sending update request with data: $data');

      final response = await _api.postUpdateConsumableEntry(data);

      if (response.statusCode == 200) {
        log('Update response: ${response.data}');
        _showSnackBar('Update successful');
        loadMaterialList();
      } else {
        log('Update failed with status: ${response.statusCode}, response: ${response.data}');
        var errMsg = 'Failed to update item: ${response.statusCode}';
        if (response.statusCode == 400) {
          errMsg += ' - Bad Request, check data';
        } else if (response.statusCode == 404) {
          errMsg += ' - Item not found';
        } else if (response.statusCode == 500) {
          errMsg += ' - Server error';
        }
        _showSnackBar(errMsg);
      }
    } on DioException catch (e) {
      log('Network error: ${e.message}');
      if (e.response != null) {
        log('Response status code: ${e.response?.statusCode}');
        log('Response data: ${e.response?.data}');
        log('Response headers: ${e.response?.headers}');
        log('Request options: ${e.response?.requestOptions}');
      }
      _showSnackBar('Network error: ${e.message}');
    } catch (e) {
      log('Unexpected error: $e');
      _showSnackBar('Unexpected error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return buildCardContent();
  }

  Widget buildCardContent() => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(75, 30, 30, 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchLineHeader(title: 'Material Management'),
                buildHeaderRow(),
                rowDataList.isEmpty
                    ? const Text('No data available')
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: rowDataList.length,
                        itemBuilder: (context, i) {
                          return EditableRow(
                            key: ValueKey(rowDataList[i].id), // Ensure each row is uniquely identified
                            row: rowDataList[i],
                            onDelete: () => deleteService(rowDataList[i]),
                            onUpdate: updateRow,
                            units: _units,
                          );
                        },
                      ),
                const SizedBox(height: 40),
                buildAddButton(),
                if (isCardVisible)
                  CardWidget(
                    onSave: _addRow,
                    onHideCard: hideCard,
                  ),
              ],
            ),
          ),
        ),
      );

  Widget buildHeaderRow() => const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text('Material', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text('Amount', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text('Einheit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text('Price', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 110),
        ],
      );

  Widget buildAddButton() => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Align(
          alignment: Alignment.topLeft,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                isCardVisible = !isCardVisible;
              });
            },
            backgroundColor: Colors.orange,
            child: Icon(isCardVisible ? Icons.remove : Icons.add, color: Colors.white),
          ),
        ),
      );

  void _addRow(String materialName, int amount, Unit unit, int price) {
    setState(() {
      rowDataList.add(ConsumableVM(
        id: rowDataList.isNotEmpty ? rowDataList.last.id + 1 : 1,
        name: materialName,
        amount: amount,
        unit: unit,
        price: price,
      ));
    });
  }
}

class EditableRow extends ConsumerStatefulWidget {
  final ConsumableVM row;
  final VoidCallback onDelete;
  final Function(ConsumableVM) onUpdate;
  final List<Unit> units;

  const EditableRow({
    super.key,
    required this.row,
    required this.onDelete,
    required this.onUpdate,
    required this.units,
  });

  @override
  ConsumerState<EditableRow> createState() => _EditableRowState();
}

class _EditableRowState extends ConsumerState<EditableRow> {
  late TextEditingController _materialNameController;
  late TextEditingController _amountController;
  late TextEditingController _priceController;
  late int currentUnitId;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _materialNameController = TextEditingController(text: widget.row.name);
    _amountController = TextEditingController(text: widget.row.amount.toString());
    currentUnitId = widget.row.unit.id;
    _priceController = TextEditingController(text: widget.row.price.toString());
    ensureValidUnitId();
  }

  void ensureValidUnitId() {
    if (!widget.units.any((unit) => unit.id == currentUnitId)) {
      currentUnitId = widget.units.isNotEmpty ? widget.units.first.id : -1;
    }
  }

  @override
  void dispose() {
    _materialNameController.dispose();
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Are you sure you want to delete this item?'),
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
            child: const Text('Yes'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
        ],
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
          children: [
            Expanded(
              child: TextField(
                controller: _materialNameController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                readOnly: !isEditing,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _amountController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                readOnly: !isEditing,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8, right: 81), // Adjust the left padding to move the dropdown more to the right
              child: SizedBox(
                width: 100, // Set your desired width
                child: Container(
                  padding: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 240, 237, 237), // Set your desired border color here
                      width: 1.0,
                    ),
                    color: const Color.fromARGB(249, 254, 255, 253),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: DropdownButton<int>(
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      value: currentUnitId == -1 ? null : currentUnitId,
                      onChanged: isEditing
                          ? (int? newValue) {
                              setState(() {
                                currentUnitId = newValue!;
                              });
                            }
                          : null,
                      items: widget.units.map<DropdownMenuItem<int>>((Unit unit) {
                        return DropdownMenuItem<int>(
                          value: unit.id,
                          child: Text(unit.name),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _priceController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                readOnly: !isEditing,
                keyboardType: TextInputType.number,
              ),
            ),
            IconButton(
              icon: Icon(isEditing ? Icons.cancel : Icons.delete),
              onPressed: isEditing
                  ? () {
                      setState(() {
                        isEditing = false;
                        _materialNameController.text = widget.row.name;
                        _amountController.text = widget.row.amount.toString();
                        currentUnitId = widget.row.unit.id;
                        _priceController.text = widget.row.price.toString();
                        ensureValidUnitId();
                      });
                    }
                  : _showDeleteConfirmation,
            ),
            IconButton(
              icon: Icon(isEditing ? Icons.save : Icons.edit),
              onPressed: () {
                if (isEditing) {
                  ConsumableVM updatedRow = ConsumableVM(
                    id: widget.row.id,
                    name: _materialNameController.text,
                    amount: int.parse(_amountController.text),
                    unit: widget.units.firstWhere((unit) => unit.id == currentUnitId, orElse: () => widget.units.first),
                    price: int.parse(_priceController.text),
                  );

                  widget.onUpdate(updatedRow);

                  setState(() {
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
