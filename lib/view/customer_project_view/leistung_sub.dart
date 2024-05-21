import 'dart:convert'; // For JSON operations

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../shared_view_widgets/search_line_header.dart';

class ConsumableLeistungBody extends StatefulWidget {
  const ConsumableLeistungBody({super.key}); // Constructor with key initialization

  @override
  // ignore: library_private_types_in_public_api
  _ConsumableLeistungBodyState createState() => _ConsumableLeistungBodyState();
}

class _ConsumableLeistungBodyState extends State<ConsumableLeistungBody> {
  List<RowData> rowDataList = [
    RowData(title: 'Reparatur Schaltung', price: '50 EUR', id: 0),
    RowData(title: 'Installation Beleuchtung', price: '60 EUR', id: 1),
    RowData(title: 'Reparatur Wasserleitung', price: '70 EUR', id: 2),
    RowData(title: 'Behebung Leckage', price: '60 EUR', id: 3),
    // const RowData(title: 'Anstrich Innenwand', price: '70 EUR'),
    // const RowData(title: 'Tapezierarbeiten', price: '50 EUR'),
    // const RowData(title: 'Kücheneinbau', price: '70 EUR'),
    // const RowData(title: 'Fensterherstellung', price: '60 EUR'),
    // const RowData(title: 'Dachisolierung', price: '40 EUR')
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  bool isLoading = true;

  Future<void> fetchData() async {
    try {
      print('Making API call to the server...');

      var response = await http
          .get(Uri.parse('https://r-wa-happ-be.azurewebsites.net/api/service/create'))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        // This function will be called if the request times out
        throw Exception('The connection has timed out, please try again!');
      });

      if (response.statusCode == 200) {
        print('Response data: ${response.body}');
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          rowDataList = data.map((item) => RowData.fromJson(item)).toList();
          isLoading = false; // Set loading to false on success
        });
      } else {
        // If the server returns a non-200 HTTP response
        print('Failed to fetch data: ${response.statusCode}');
        throw Exception('Failed to load data: HTTP status ${response.statusCode}');
      }
    } catch (e) {
      // This catches errors related to the request itself, such as network issues or the timeout exception
      _showSnackBar('Error: $e');
      setState(() {
        isLoading = false; // Set loading to false on error
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

  void removeRow(RowData row) {
    setState(() {
      rowDataList.remove(row);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while data is being fetched
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Main content of your widget
    return Container(
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
              const Row(
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
              ),
              ...rowDataList
                  .map((rowData) => EditableRow(
                        originalTitle: rowData.title,
                        originalPrice: rowData.price,
                        onDelete: () => removeRow(rowData),
                      ))
                  ,
              const SizedBox(height: 40),
              Padding(
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
              ),
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
  }

  void _addRow(String title, String price) {
    setState(() {
      rowDataList.add(RowData(title: title, price: price, id: 1));
    });
  }
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

  @override
  void dispose() {
    _leistungController.dispose();

    _preisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
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
                      // This row will always be at the bottom
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
                              widget.onSave(leistung, preis);
                              _leistungController.clear();
                              _preisController.clear();
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text('Bitte füllen Sie alle Felder aus'),
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

class RowData {
  int id;
  String title;
  String price;

  RowData({required this.id, required this.title, required this.price});

  factory RowData.fromJson(Map<String, dynamic> json) => RowData(
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

  const EditableRow({
    super.key,
    required this.originalTitle,
    required this.originalPrice,
    required this.onDelete,
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
    // Listener for _priceController to append '€' if it's not already there
    // _priceController.addListener(() {
    //   String text = _priceController.text;
    //   if (!text.endsWith('€') && text.isNotEmpty) {
    //     String newText = '$text';
    //     _priceController.value = _priceController.value.copyWith(
    //       text: newText,
    //       selection: TextSelection.collapsed(offset: newText.length - 1),
    //     );
    //   }
    // });

    // Initialize currentTitle similar to how currentPrice was handled
    currentTitle = widget.originalTitle;
  }

  @override
  void dispose() {
    _titleController.dispose();

    _priceController.dispose();

    super.dispose();
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
                setState(() {
                  if (isEditing) {
                    // Save the current text field contents
                    currentTitle = _titleController.text;
                    currentPrice = _priceController.text; // Append currency symbol
                    isEditing = false; // Exit editing mode
                  } else {
                    isEditing = true; // Enter editing mode
                  }
                });
              },
            ),

            // IconButton(
            //   icon: Icon(Icons.delete),
            //   onPressed: () {
            //     setState(() {
            //       // Perform delete action
            //       widget.onDelete();
            //     });
            //   },
            // ),

            // IconButton(
            //   icon: Icon(isEditing ? Icons.settings : Icons.delete),
            //   onPressed: () {
            //     setState(() {
            //       if (!isEditing) {
            //         widget.onDelete();
            //       }
            //       isEditing = !isEditing;
            //       if (!isEditing) {
            //         _titleController.text = currentTitle;
            //         _priceController.text = currentPrice;
            //       }
            //     });
            //   },
            // ),
          ],
        ),
      );
}
