// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/constants/api/api.dart';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON operations

import '../shared_view_widgets/search_line_header.dart';

class ConsumableLeistungBody extends StatefulWidget {
  const ConsumableLeistungBody({super.key}); // Constructor with key initialization

  @override
  // ignore: library_private_types_in_public_api
  _ConsumableLeistungBodyState createState() => _ConsumableLeistungBodyState();
}

class _ConsumableLeistungBodyState extends State<ConsumableLeistungBody> {
  List<Service> rowDataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  bool isLoading = true;

  Future<void> fetchData() async {
    final Api api = Api();
    try {
      print('Making API call to the server...');
      final response = await api.getExecuteableServices.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('The connection has timed out, please try again!');
        },
      );

      if (response.statusCode == 200) {
        print('Response data: ${response.data}');
        List<dynamic> data = response.data;
        setState(() {
          rowDataList = data.map((item) => Service.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
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
    final Api api = Api();

    try {
      final response = await api.deleteService(row.id);
      print('Received response status code: ${response.statusCode} for row ID: ${row.id}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Successfully deleted row with ID: ${row.id} from the backend.');
        await fetchData(); // Fetch the updated list of services after deletion
        _showSnackBar('Row deleted successfully.');
      } else {
        print(
            'Failed to delete row with ID: ${row.id}. Status code: ${response.statusCode}, Response data: ${response.data}');
        _showSnackBar('Failed to delete the item from the server: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception when trying to delete row with ID: ${row.id}: $e');
      _showSnackBar('Error when attempting to delete the item: $e');
    }
  }

  // void deleteService(Service row) async {
  //   final Api api = Api();

  //   try {
  //     final response = await api.deleteService(row.id);
  //     print('Received response status code: ${response.statusCode} for row ID: ${row.id}');

  //     if (response.statusCode == 200 || response.statusCode == 204) {
  //       print('Successfully deleted row with ID: ${row.id} from the backend.');
  //       api.getExecuteableServices(),
  //       setState(() {
  //         // TODO: new loading from Database
  //         rowDataList.removeWhere((item) => item.id == row.id);
  //       });
  //     } else {
  //       print(
  //           'Failed to delete row with ID: ${row.id}. Status code: ${response.statusCode}, Response data: ${response.data}');
  //       _showSnackBar('Failed to delete the item from the server: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Exception when trying to delete row with ID: ${row.id}: $e');
  //     _showSnackBar('Error when attempting to delete the item: $e');
  //   }
  // }

  // void deleteService(Service row) async {
  //   final url = Uri.parse('https://r-wa-happ-be.azurewebsites.net/api/service/delete/${row.id}');
  //   try {
  //     final response = await http.delete(url);

  //     print('Received response status code: ${response.statusCode} for row ID: ${row.id}');

  //     if (response.statusCode == 200 || response.statusCode == 204) {
  //       print('Successfully deleted row with ID: ${row.id} from the backend.');
  //       setState(() {
  //         // TODO: new loading from Database
  //         rowDataList.removeWhere((item) => item.id == row.id);
  //       });
  //     } else {
  //       print(
  //           'Failed to delete row with ID: ${row.id}. Status code: ${response.statusCode}, Response data: ${response.body}');
  //       _showSnackBar('Failed to delete the item from the server: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Exception when trying to delete row with ID: ${row.id}: $e');
  //     _showSnackBar('Error when attempting to delete the item: $e');
  //   }
  // }

  Future<void> updateRow(Service row) async {
    final url = Uri.parse('https://r-wa-happ-be.azurewebsites.net/api/service/update');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your_access_token',
        },
        body: jsonEncode(row.toJson()),
      );

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

// void removeRow(RowData row) {
//     print("Deleting row with ID: ${row.id}"); // Debugging output
//     setState(() {
//       rowDataList.removeWhere((item) => item.id == row.id);
//     });
// }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while data is being fetched
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return buildCardContent();
  }

  // Main content of your widget
  Widget buildCardContent() => Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(75, 30, 30, 15),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchLineHeader(title: 'Leistungsverwaltung'),
            const SizedBox(height: 44),
            buildHeaderRow(),
            ...rowDataList.map((rowData) => EditableRow(
              key: ValueKey(rowData.id),
              originalTitle: rowData.title,
              originalPrice: rowData.price,
              onDelete: () => deleteService(rowData),
              onUpdate: (updatedRow) => updateRow(updatedRow), // Now passing onUpdate
              row: rowData,
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
        child: Text('Leistung', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      SizedBox(width: 30),
      Expanded(
        child: Text('Preis/std', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      Spacer(),
      SizedBox(width: 110) // Adjust spacing as needed
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
        child: Icon(isCardVisible ? Icons.remove : Icons.add, color: Colors.white),
        backgroundColor: Colors.orange,
      ),
    ),
  );

  void _addRow(String title, String price) {
    setState(() {
      rowDataList.add(Service(title: title, price: price, id: 1));
    });
  }
}

class Service {
  int id;
  String title;
  String price;

  Service({required this.id, required this.title, required this.price});

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json['id'],
    title: json['name'],
    price: '${json['hourlyRate']} EUR',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': title,
    'hourlyRate': int.tryParse(price.split(' ')[0]) ?? 0,
  };
}

class EditableRow extends StatefulWidget {
  final String originalTitle;

  final String originalPrice;
  final VoidCallback onDelete;
  final Function(Service) onUpdate;
  final Service row;

  const EditableRow({
    super.key,
    required this.originalTitle,
    required this.originalPrice,
    required this.onDelete,
    required this.onUpdate,
    required this.row,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditableRowState createState() => _EditableRowState();
}

class _EditableRowState extends State<EditableRow> {
  late TextEditingController _titleController;

  late TextEditingController _priceController;
  late String currentTitle;
  late String currentPrice;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize all controllers here
    _titleController = TextEditingController(text: widget.originalTitle);

    // Initialize currentPrice before using it to set up _priceController
    currentPrice = widget.originalPrice; // Set currentPrice from widget's originalPrice
    _priceController = TextEditingController(text: widget.originalPrice);

    currentTitle = widget.originalTitle;
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
      barrierDismissible: false, // Dialog cannot be dismissed by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4, // 80% of screen width
            height: MediaQuery.of(context).size.height * 0.3, // 40% of screen height
            child: AlertDialog(
              title: Text('Sind Sie sicher, dass Sie dieses Objekt löschen wollen?'),
              // content: Text("Sind Sie sicher, dass Sie dieses Objekt löschen wollen?"),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    widget.onDelete(); // Proceed with deleting the row
                  },
                  child: Text('Ja'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Nein'),
                ),
              ],
            ),
          ),
        );
      },
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
        // IconButton to handle cancel action
        IconButton(
          icon: Visibility(
            visible: isEditing, // Show cancel icon only when editing
            child: const Icon(Icons.cancel),
          ),
          onPressed: () {
            setState(() {
              // Check if currently editing
              if (isEditing) {
                isEditing = false; // Disable editing mode
                // Revert text fields to their original values
                _titleController.text = currentTitle;
                _priceController.text = currentPrice;
              }
            });
          },
        ),

// IconButton to toggle between save and edit modes

        IconButton(
          icon: Icon(isEditing ? Icons.save : Icons.edit),
          onPressed: () {
            if (isEditing) {
              Service updatedRow =
              Service(id: widget.row.id, title: _titleController.text, price: _priceController.text);

              widget.onUpdate(updatedRow);

              setState(() {
                currentTitle = _titleController.text;
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

        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: _showDeleteConfirmation,
        ),
      ],
    ),
  );
}

class CardWidget extends StatefulWidget {
  final Function(String title, String price) onSave;
  final Function onHideCard;

  const CardWidget({required this.onSave, required this.onHideCard, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final TextEditingController _leistungController = TextEditingController();

  final TextEditingController _preisController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _leistungController.dispose();

    _preisController.dispose();
    super.dispose();
  }

  void createService() async {
    final String leistung = _leistungController.text.trim();
    final String preis = _preisController.text.trim();

    if (leistung.isEmpty || preis.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Fehler'),
          content: const Text('Alle Felder müssen ausgefüllt sein!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });
      final response = await http.post(
        Uri.parse('https://r-wa-happ-be.azurewebsites.net/api/service/create'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'name': leistung,
          'hourlyRate': preis,
        }),
      );

      if (response.statusCode == 200) {
        widget.onSave(leistung, preis);

        if (Navigator.canPop(context)) {
          Navigator.of(context).pop(); // Only pop if there's a stack to pop from.
        }
      } else {
        throw Exception('Failed to create service.');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Fehler beim Speichern'),
          content: Text('Ein Fehler ist aufgetreten: $e'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false; // Stop loading after the API call completes
      });
    }
  }

  @override
  Widget build(BuildContext context) => _isLoading
      ? const Center(child: CircularProgressIndicator()) // Show loading indicator
      : SizedBox(
    width: double.maxFinite,
    height: 350,
    child: Card(
      surfaceTintColor: Colors.white,
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Leistung',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Expanded(
                              child: TextField(
                                controller: _leistungController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color.fromARGB(211, 245, 241, 241),
                                  hintText: 'Leistung',
                                  contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text('Preis/std', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 15),
                            Expanded(
                              child: TextField(
                                controller: _preisController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color.fromARGB(211, 245, 241, 241),
                                  hintText: 'Preis/std',
                                  contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _leistungController.clear();
                        _preisController.clear();
                        widget.onHideCard();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Color.fromARGB(255, 231, 226, 226), width: 1.0),
                        ),
                      ),
                      child: const Text(
                        'Verwerfen',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        final leistung = _leistungController.text;
                        final preis = _preisController.text;
                        if (leistung.isNotEmpty && preis.isNotEmpty) {
                          if (!_isLoading) {
                            createService();
                          } else {
                            // Show a snackbar when the app is still processing a previous request
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Bitte warten Sie, während der Service gespeichert wird.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Fehlende Informationen'),
                              content: const Text('Bitte füllen Sie alle Felder aus.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Color.fromARGB(255, 231, 226, 226), width: 1.0),
                        ),
                      ),
                      child: const Text(
                        'Speichern',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}