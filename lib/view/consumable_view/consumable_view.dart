// import 'dart:convert'; // For JSON operations
// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../models/consumable_models/consumable_vm/consumable_vm.dart';
// import '/constants/api/api.dart'; // Assuming this contains the Api class
// import '../../models/consumable_models/unit/unit.dart';
// import '../../provider/consumeable_proivder/consumable_provider.dart';
// import '../shared_view_widgets/search_line_header.dart';
// import 'widgets/card_widget.dart';

// class ConsumableBody extends ConsumerStatefulWidget {
//   const ConsumableBody({super.key}); // Constructor with key initialization

//   @override
//   ConsumerState<ConsumableBody> createState() => _ConsumableBodyState();
// }

// class _ConsumableBodyState extends ConsumerState<ConsumableBody> {
//   final List<Unit> _units = [];
//   // TODO: change Service with ConsumableVM
//   final List<ConsumableVM> rowDataList = [];
//   final Api _api = Api();

//   @override
//   void initState() {
//     super.initState();
//     loadMaterialList();
//   }

//   bool isLoading = true;
//   void loadUnits() {
//     ref.read(consumableProvider.notifier).loadUnits().then(
//           (value) => setState(() => _units.addAll(value)),
//         );
//   }

//   Future<void> loadMaterialList() async {
//     ref.read(consumableProvider.notifier).loadConsumables();
//     final material = ref.watch(consumableProvider);
//     try {
//       final response = await _api.getMaterialsList;
//       // .timeout(
//       //   const Duration(seconds: 10),
//       //   onTimeout: () {
//       //     throw Exception('The connection has timed out, please try again!');
//       //   },
//       // );

//       if (response.statusCode == 200) {
//         // final responseData = response.data is String ? response.data : json.encode(response.data);

//         final List data = response.data.map((e) => e).toList();
//         // json.decode(responseData);
//         log('Decoded response data:\n$data');

//         // final services = data.map((item) => Service.fromJson(item)).toList();
//         setState(() {
//           // rowDataList.addAll(services);
//           log('Updated rowDataList: ${json.encode(rowDataList)}');
//           isLoading = false;
//         });

//         for (var item in rowDataList) {
//           log('Service Item: ${item.toJson()}');
//         }
//       } else {
//         log('Failed to fetch data: ${response.statusCode}');
//         _showSnackBar('Failed to fetch data: HTTP status ${response.statusCode}');
//         throw Exception('error occurent ${response.data}');
//       }
//     } catch (e) {
//       log('Error processing response data: $e');
//       _showSnackBar('Error: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   void _showSnackBar(String message) {
//     final snackBar = SnackBar(content: Text(message));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   bool isCardVisible = false;

//   void hideCard() {
//     setState(() {
//       isCardVisible = false;
//     });
//   }

//   void deleteService(Service row) async {
//     try {
//       final response = await _api.deleteServiceMaterial(row.id);

//       log('Received response status code: ${response.statusCode} for row ID: ${row.id}');

//       if (response.statusCode == 200 || response.statusCode == 204) {
//         log('Successfully deleted row with ID: ${row.id} from the backend.');
//         await loadMaterialList(); // Fetch the updated list of services after deletion
//         _showSnackBar('Row deleted successfully.');
//       } else {
//         log('Failed to delete row with ID: ${row.id}. Status code: ${response.statusCode}');
//         _showSnackBar('Failed to delete the item from the server: ${response.statusCode}');
//       }
//     } catch (e) {
//       log('Exception when trying to delete row with ID: ${row.id}: $e');
//       _showSnackBar('Error when attempting to delete the item: $e');
//     }
//   }

//   Future<void> updateRow(Service row) async {
//     try {
//       final data = row.toJson();
//       log('Sending update request with data: $data');

//       final response = await _api.updateConsumableEntry(data);

//       if (response.statusCode == 200) {
//         log('Update response: ${response.data}');
//         _showSnackBar('Update successful');
//         await loadMaterialList();
//       } else {
//         log('Update failed with status: ${response.statusCode}, response: ${response.data}');
//         var errMsg = 'Failed to update item: ${response.statusCode}';
//         if (response.statusCode == 400) {
//           errMsg += ' - Bad Request, check data';
//         } else if (response.statusCode == 404) {
//           errMsg += ' - Item not found';
//         } else if (response.statusCode == 500) {
//           errMsg += ' - Server error';
//         }
//         _showSnackBar(errMsg);
//       }
//     } on DioException catch (e) {
//       log('Network error: ${e.message}');
//       if (e.response != null) {
//         log('Response status code: ${e.response?.statusCode}');
//         log('Response data: ${e.response?.data}');
//         log('Response headers: ${e.response?.headers}');
//         log('Request options: ${e.response?.requestOptions}');
//       }
//       _showSnackBar('Network error: ${e.message}');
//     } catch (e) {
//       log('Unexpected error: $e');
//       _showSnackBar('Unexpected error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     return buildCardContent();
//   }

//   Widget buildCardContent() => Container(
//         color: Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(75, 30, 30, 15),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SearchLineHeader(title: 'Material Management'),
//                 const SizedBox(height: 44),
//                 buildHeaderRow(),
//                 ...rowDataList.map((rowData) => EditableRow(
//                       key: ValueKey(rowData.id),
//                       row: rowData,
//                       onDelete: () => deleteService(rowData),
//                       onUpdate: (updatedRow) => updateRow(updatedRow),
//                     )),
//                 const SizedBox(height: 40),
//                 buildAddButton(),
//                 if (isCardVisible)
//                   CardWidget(
//                     onSave: _addRow,
//                     onHideCard: hideCard,
//                   ),
//               ],
//             ),
//           ),
//         ),
//       );

//   Widget buildHeaderRow() => const Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Text('Material', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           ),
//           Expanded(
//             child: Text('Amount', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           ),
//           Expanded(
//             child: Text('Einheit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           ),
//           Expanded(
//             child: Text('Price', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           ),
//           SizedBox(width: 110),
//         ],
//       );

//   Widget buildAddButton() => Padding(
//         padding: const EdgeInsets.only(bottom: 8),
//         child: Align(
//           alignment: Alignment.topLeft,
//           child: FloatingActionButton(
//             onPressed: () {
//               setState(() {
//                 isCardVisible = !isCardVisible;
//               });
//             },
//             backgroundColor: Colors.orange,
//             child: Icon(isCardVisible ? Icons.remove : Icons.add, color: Colors.white),
//           ),
//         ),
//       );

//   void _addRow(String materialName, int amount, Unit unit, int price) {
//     setState(() {
//       rowDataList.add(ConsumableVM(
//         id: rowDataList.isNotEmpty ? rowDataList.last.id + 1 : 1,
//         name: materialName,
//         amount: amount,
//         unit: unit,
//         price: price,
//       ));
//     });
//   }
// }

// class Service {
//   int id;
//   String materialName;
//   String amount;
//   Unit unit;
//   int price;

//   Service({
//     required this.id,
//     required this.materialName,
//     required this.amount,
//     required this.unit,
//     required this.price,
//   });

//   factory Service.fromJson(Map<String, dynamic> json) => Service(
//         id: json['id'],
//         materialName: json['name'],
//         amount: json['amount'].toString(),
//         unit: json['materialUnitID'],
//         price: json['price'].,
//       );

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'name': materialName,
//         'amount': amount,
//         'materialUnitID': unit.id,
//         'price': price,
//       };
// }

// class EditableRow extends ConsumerStatefulWidget {
//   final Service row;
//   final VoidCallback onDelete;
//   final Function(Service) onUpdate;

//   const EditableRow({
//     super.key,
//     required this.row,
//     required this.onDelete,
//     required this.onUpdate,
//   });

//   @override
//   ConsumerState<EditableRow> createState() => _EditableRowState();
// }

// class _EditableRowState extends ConsumerState<EditableRow> {
//   late TextEditingController _materialNameController;
//   late TextEditingController _amountController;
//   late TextEditingController _unitNameController;
//   late TextEditingController _priceController;
//   bool isEditing = false;
//   late Service consumable;
//   final List<Unit> _units = [];
//   Unit? _selecedUnit;
//   @override
//   void initState() {
//     consumable = widget.row;
//     super.initState();
//     _materialNameController = TextEditingController(text: widget.row.materialName);
//     _amountController = TextEditingController(text: widget.row.amount.toString()); // Ensure this is a String
//     // _unitNameController = TextEditingController(text: widget.row.unit);

//     _priceController = TextEditingController(text: widget.row.price.toString()); // Ensure this is a String
//     loadUnits();
//   }

//   void loadUnits() {
//     ref.read(consumableProvider.notifier).loadUnits().then(
//           (value) => setState(() {
//             _units.addAll(value);
//           }),
//         );
//   }

//   @override
//   void dispose() {
//     _materialNameController.dispose();
//     _amountController.dispose();
//     _unitNameController.dispose();
//     _priceController.dispose();
//     super.dispose();
//   }

//   void _showDeleteConfirmation() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) => Dialog(
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width * 0.4,
//           height: MediaQuery.of(context).size.height * 0.3,
//           child: AlertDialog(
//             title: const Text('Are you sure you want to delete this item?'),
//             actionsAlignment: MainAxisAlignment.spaceEvenly,
//             actions: <Widget>[
//               TextButton(
//                 style: TextButton.styleFrom(
//                   backgroundColor: Colors.orange,
//                   foregroundColor: Colors.white,
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   widget.onDelete();
//                 },
//                 child: const Text('Yes'),
//               ),
//               TextButton(
//                 style: TextButton.styleFrom(
//                   backgroundColor: Colors.orange,
//                   foregroundColor: Colors.white,
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('No'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) => Container(
//         padding: const EdgeInsets.only(bottom: 12, top: 15),
//         decoration: const BoxDecoration(
//           border: Border(
//             bottom: BorderSide(
//               color: Colors.black,
//               width: 1.0,
//             ),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: _materialNameController,
//                 style: const TextStyle(fontSize: 16),
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.zero,
//                 ),
//                 readOnly: !isEditing,
//               ),
//             ),
//             Expanded(
//               child: TextField(
//                 controller: _amountController,
//                 style: const TextStyle(fontSize: 16),
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.zero,
//                 ),
//                 readOnly: !isEditing,
//               ),
//             ),
//             Expanded(
//               child: isEditing
//                   ? DropdownButton(
//                       items: _units
//                           .map((e) => DropdownMenuItem(
//                                 child: (Text(e.name)),
//                               ))
//                           .toList(),
//                       value: _units.firstWhere((e) => e.name == consumable.materialName),
//                       onChanged: (value) {
//                         log('changed ${value}');
//                         setState(() {
//                           _selecedUnit = value;
//                         });
//                       },
//                     )
//                   : Text(consumable.materialName),
//               // TextField(
//               //   controller: _unitNameController,
//               //   style: const TextStyle(fontSize: 16),
//               //   decoration: const InputDecoration(
//               //     border: InputBorder.none,
//               //     contentPadding: EdgeInsets.zero,
//               //   ),
//               //   readOnly: !isEditing,
//               // ),
//             ),
//             Expanded(
//               child: TextField(
//                 controller: _priceController,
//                 style: const TextStyle(fontSize: 16),
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.zero,
//                 ),
//                 readOnly: !isEditing,
//               ),
//             ),
//             IconButton(
//               icon: Icon(isEditing ? Icons.cancel : Icons.delete),
//               onPressed: isEditing
//                   ? () {
//                       setState(() {
//                         isEditing = false;
//                         _materialNameController.text = widget.row.materialName;
//                         _amountController.text = widget.row.amount.toString();
//                         // _unitNameController.text = widget.row.unit;
//                         _priceController.text = widget.row.price.toString();
//                       });
//                     }
//                   : _showDeleteConfirmation,
//             ),
//             IconButton(
//               icon: Icon(isEditing ? Icons.save : Icons.edit),
//               onPressed: () {
//                 if (isEditing) {
//                   if (_selecedUnit != null) {
//                     Service updatedRow = Service(
//                       id: widget.row.id,
//                       materialName: _materialNameController.text,
//                       amount: _amountController.text,
//                       unit: _selecedUnit!,
//                       price: int.parse(_priceController.text),
//                     );

//                     widget.onUpdate(updatedRow);

//                     setState(() {
//                       isEditing = false;
//                     });
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Bitte wähle eine Einehit aus')),
//                     );
//                   }
//                 } else {
//                   setState(() {
//                     isEditing = true;
//                   });
//                 }
//               },
//             ),
//           ],
//         ),
//       );
// }

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
  const ConsumableBody({super.key}); // Constructor with key initialization

  @override
  ConsumerState<ConsumableBody> createState() => _ConsumableBodyState();
}

class _ConsumableBodyState extends ConsumerState<ConsumableBody> {
  List<Unit> _units = [];
  List<ConsumableVM> rowDataList = [];
  final Api _api = Api();

  @override
  void initState() {
    super.initState();
    loadMaterialList();
    // loadUnits();
  }

  bool isLoading = true;

  void loadUnits() {
    setState(() => isLoading = true);
    ref.read(consumableProvider.notifier).loadUnits().then(
      (value) {
        loadMaterialList();
        setState(() => _units.addAll(value));
        log('units-> ${_units.length}');
      },
    );
  }

  void loadMaterialList() {
    setState(() => isLoading = true);
    ref.read(consumableProvider.notifier).loadConsumables().then((value) {
      setState(() {
        _units.addAll(value);
        rowDataList = ref.watch(consumableProvider);
        isLoading = false;
      });
    });

    // try {
    //   final response = await _api.getMaterialsList;

    //   if (response.statusCode == 200) {
    //     final List data = json.decode(response.data).map((e) => e).toList();
    //     log('Decoded response data:\n$data');

    //     setState(() {
    //       rowDataList.addAll(data.map((item) => ConsumableVM.fromJson(item)).toList());
    //       isLoading = false;
    //     });

    //     for (var item in rowDataList) {
    //       log('Service Item: ${item.toJson()}');
    //     }
    //   } else {
    //     log('Failed to fetch data: ${response.statusCode}');
    //     _showSnackBar('Failed to fetch data: HTTP status ${response.statusCode}');
    //     throw Exception('Error occurred ${response.data}');
    //   }
    // } catch (e) {
    //   log('Error processing response data: $e');
    //   _showSnackBar('Error: $e');
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
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

  void deleteService(ConsumableVM row) async {
    try {
      final response = await _api.deleteServiceMaterial(row.id);

      log('Received response status code: ${response.statusCode} for row ID: ${row.id}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        log('Successfully deleted row with ID: ${row.id} from the backend.');
        // await loadMaterialList();
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

  Future<void> updateRow(ConsumableVM row) async {
    try {
      final data = row.toJson();
      log('Sending update request with data: $data');

      final response = await _api.putUpdateConsumableEntry(data);

      if (response.statusCode == 200) {
        log('Update response: ${response.data}');
        _showSnackBar('Update successful');
        // await loadMaterialList();
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
                SizedBox(
                  height: 44,
                  child: Text('${rowDataList.first.name}'),
                ),
                buildHeaderRow(),
                rowDataList.isEmpty
                    ? const Text('load data')
                    : SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: rowDataList.length,
                          itemBuilder: (context, i) {
                            log('${rowDataList[i].toJson()}');
                            return EditableRow(
                              row: rowDataList[i],
                              onDelete: () {},
                              onUpdate: (_) {},
                              units: _units,
                            );
                          },
                        ),
                      ),
                // ...rowDataList.map((rowData) => EditableRow(
                //       // key: ValueKey(rowData.id),
                //       row: rowData,
                //       onDelete: () => deleteService(rowData),
                //       onUpdate: (updatedRow) => updateRow(updatedRow),
                //       units: _units,
                //     )),
                const SizedBox(height: 40),
                buildAddButton(),
                if (isCardVisible)
                  CardWidget(
                    onSave: _addRow,
                    onHideCard: hideCard,
                    // units: _units,
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
                keyboardType: TextInputType.number,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 4),
                decoration: BoxDecoration(border: Border.all(), color: Colors.grey[100]),
                child: DropdownButton<int>(
                  isExpanded: true,
                  underline: SizedBox.shrink(),
                  value: currentUnitId,
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
                    unit: widget.units.firstWhere((unit) => unit.id == currentUnitId),
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
