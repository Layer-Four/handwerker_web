// ignore_for_file: use_build_context_synchronously

import 'dart:convert'; // For JSON operations
import 'dart:developer';

import 'package:flutter/material.dart';

import '../customer_project_view/card_widget.dart';
import '../shared_view_widgets/search_line_header.dart';
import '/constants/api/api.dart';

class ConsumableBody extends StatefulWidget {
  const ConsumableBody({super.key}); // Constructor with key initialization

  @override
  State<ConsumableBody> createState() => _ConsumableBodyState();
}

class _ConsumableBodyState extends State<ConsumableBody> {
  List<Service> rowDataList = [];
  final Api _api = Api();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  bool isLoading = true;

  // Future<void> fetchData() async {
  //   // final url = Uri.parse('https://r-wa-happ-be.azurewebsites.net/api/material/list');
  //   try {
  //     print('Making API call to the server...');
  //     // final e = await _api.updateConsumableEntry({'hallo': 15});
  //     final response = await _api.getMaterialsList.timeout(
  //       const Duration(seconds: 10),
  //       onTimeout: () {
  //         throw Exception('The connection has timed out, please try again!');
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       print('Response data: ${response.data}');
  //       List<dynamic> data = json.decode(response.data);
  //       setState(() {
  //         rowDataList = data.map((item) => Service.fromJson(item)).toList();
  //         isLoading = false;
  //       });
  //     } else {
  //       print('Failed to fetch data: ${response.statusCode}');
  //       throw Exception('Failed to load data: HTTP status ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     _showSnackBar('Error: $e');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }
  Future<void> fetchData() async {
    try {
      log('Making API call to the server...');
      final response = await _api.getMaterialsList.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('The connection has timed out, please try again!');
        },
      );

      if (response.statusCode == 200) {
        log('Response data: ${response.data}');

        // Check if response.data is a string, if not, convert it
        final responseData = response.data is String ? response.data : json.encode(response.data);

        List<dynamic> data = json.decode(responseData);
        setState(() {
          rowDataList = data.map((item) => Service.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        log('Failed to fetch data: ${response.statusCode}');
        throw Exception('Failed to load data: HTTP status ${response.statusCode}');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool isCardVisible = false;

  void hideCard() {
    setState(() {
      isCardVisible = false;
    });
  }

  void deleteService(Service row) async {
    try {
      final response = await _api.deleteServiceMaterial(row.id);

      log('Received response status code: ${response.statusCode} for row ID: ${row.id}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        log('Successfully deleted row with ID: ${row.id} from the backend.');
        await fetchData(); // Fetch the updated list of services after deletion
        _showSnackBar('Row deleted successfully.');
      } else {
        log('Failed to delete row with ID: ${row.id}. Status code: ${response.statusCode}');
        _showSnackBar('Failed to delete the item from the server: ${response.statusCode}');
      }
    } catch (e) {
      log('Exception when trying to delete row with ID: ${row.id}: $e');
      _showSnackBar('Error when attempting to delete the item: $e');
    }
  }

  Future<void> updateRow(Service row) async {
    try {
      final data = row.toJson();
      log('Sending update request with data: $data');

      final response = await _api.updateConsumableEntry(data);

      if (response.statusCode == 200) {
        _showSnackBar('Update successful');
      } else {
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
    } catch (e) {
      _showSnackBar('Network error: $e');
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
                const SizedBox(height: 44),
                buildHeaderRow(),
                ...rowDataList.map((rowData) => EditableRow(
                      key: ValueKey(rowData.id),
                      row: rowData,
                      onDelete: () => deleteService(rowData),
                      onUpdate: (updatedRow) => updateRow(updatedRow),
                    )),
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

  void _addRow(String materialName, String amount, String unitName, String price) {
    setState(() {
      rowDataList.add(Service(
        id: rowDataList.isNotEmpty ? rowDataList.last.id + 1 : 1,
        materialName: materialName,
        amount: amount,
        unitName: unitName,
        price: price,
      ));
    });
  }
}

class Service {
  int id;
  String materialName;
  String amount;
  String unitName;
  String price;

  Service({
    required this.id,
    required this.materialName,
    required this.amount,
    required this.unitName,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json['id'],
        materialName: json['name'],
        amount: json['amount'].toString(),
        unitName: json['materialUnitName'],
        price: json['price'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': materialName,
        'amount': amount,
        'materialUnitName': unitName,
        'price': price,
      };
}

class EditableRow extends StatefulWidget {
  final Service row;
  final VoidCallback onDelete;
  final Function(Service) onUpdate;

  const EditableRow({
    super.key,
    required this.row,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  State<EditableRow> createState() => _EditableRowState();
}

class _EditableRowState extends State<EditableRow> {
  late TextEditingController _materialNameController;
  late TextEditingController _amountController;
  late TextEditingController _unitNameController;
  late TextEditingController _priceController;
  late String currentMaterialName;
  late String currentAmount;
  late String currentUnitName;
  late String currentPrice;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _materialNameController = TextEditingController(text: widget.row.materialName);
    _amountController = TextEditingController(text: widget.row.amount);
    _unitNameController = TextEditingController(text: widget.row.unitName);
    _priceController = TextEditingController(text: widget.row.price);
    currentMaterialName = widget.row.materialName;
    currentAmount = widget.row.amount;
    currentUnitName = widget.row.unitName;
    currentPrice = widget.row.price;
  }

  @override
  void dispose() {
    _materialNameController.dispose();
    _amountController.dispose();
    _unitNameController.dispose();
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
              ),
            ),
            Expanded(
              child: TextField(
                controller: _unitNameController,
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
                controller: _priceController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                readOnly: !isEditing,
              ),
            ),
            IconButton(
              icon: Icon(isEditing ? Icons.cancel : Icons.delete),
              onPressed: isEditing
                  ? () {
                      setState(() {
                        isEditing = false;
                        _materialNameController.text = currentMaterialName;
                        _amountController.text = currentAmount;
                        _unitNameController.text = currentUnitName;
                        _priceController.text = currentPrice;
                      });
                    }
                  : _showDeleteConfirmation,
            ),
            IconButton(
              icon: Icon(isEditing ? Icons.save : Icons.edit),
              onPressed: () {
                if (isEditing) {
                  Service updatedRow = Service(
                    id: widget.row.id,
                    materialName: _materialNameController.text,
                    amount: _amountController.text,
                    unitName: _unitNameController.text,
                    price: _priceController.text,
                  );

                  widget.onUpdate(updatedRow);

                  setState(() {
                    currentMaterialName = _materialNameController.text;
                    currentAmount = _amountController.text;
                    currentUnitName = _unitNameController.text;
                    currentPrice = _priceController.text;
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

class Unit {
  final int id;
  final String name;

  Unit({required this.id, required this.name});

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json['id'],
        name: json['name'],
      );
}
