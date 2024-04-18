import 'package:flutter/material.dart';
// import '../../models/consumable_models/consumable_vm/consumable_vm.dart';
// import '../shared_view_widgets/symetric_button_widget.dart';

class ConsumableBody extends StatefulWidget {
  const ConsumableBody({super.key}); // Constructor with key initialization

  @override
  // ignore: library_private_types_in_public_api
  _ConsumableBodyState createState() => _ConsumableBodyState();
}

class _ConsumableBodyState extends State<ConsumableBody> {
  List<RowData> rowDataList = [
    const RowData(
        title: 'Montage Allgemein',
        Menge: '2',
        Measurement: 'm',
        price: '120€'),
    const RowData(
        title: 'Montage Fenster', Menge: '6', Measurement: 'cm', price: '80€'),
    const RowData(
        title: 'Montage Allgemein Meister',
        Menge: '7',
        Measurement: 'm3',
        price: '540€'),
  ];
  bool isCardVisible = false;
  void hideCard() {
    setState(() {
      isCardVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: SizedBox(
                    width: 400,
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(
                          12), // Ensure the Material also has rounded corners
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'Suchen...', // Placeholder text
                          fillColor: Colors
                              .white, // Background color of the text field
                          filled: true,
                          suffixIcon: const Icon(Icons.search,
                              color: Colors.grey), // Search icon on the right
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                            borderSide: BorderSide.none, // No visible border
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.transparent,
                                width:
                                    0), // Transparent border to maintain consistency
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.white,
                                width:
                                    2), // Highlight with an orange border when focused
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 44,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Material',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Menge',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Expanded(
                      child: Text(
                        'Einheit',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Text(
                        'Preis/mengeneinheit',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Spacer(),
                    SizedBox(
                      width: 110,
                    )
                  ],
                ),
                for (var rowData in rowDataList)
                  EditableRow(
                    originalTitle: rowData.title,
                    originalMenge: rowData.Menge,
                    originalMeausrement: rowData.Measurement,
                    originalPrice: rowData.price,
                    onDelete: () {
                      setState(() {
                        rowDataList.remove(rowData);
                      });
                    },
                  ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius:
                            BorderRadius.circular(50), // Fully rounded corners
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isCardVisible = !isCardVisible;
                          });
                        },
                        iconSize:
                            30, // Adjust the size of the icon if necessary
                        padding: EdgeInsets
                            .zero, // Remove any default padding to ensure centering
                        alignment: Alignment
                            .center, // Ensure the icon is centered in the button
                        icon: isCardVisible
                            ? const Icon(Icons.remove, color: Colors.white)
                            : const Icon(Icons.add, color: Colors.white),
                      ),
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

  void _addRow(String title, String menge, String measurement, String price) {
    setState(() {
      rowDataList.add(RowData(
          title: title, Menge: menge, Measurement: measurement, price: price));
    });
  }
}

class CardWidget extends StatefulWidget {
  final Function(String title, String menge, String measurement, String price)
      onSave;
  final Function onHideCard;

  const CardWidget({required this.onSave, required this.onHideCard, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final TextEditingController _leistungController = TextEditingController();
  final TextEditingController _mengeController = TextEditingController();
  final TextEditingController _measurementController = TextEditingController();
  final TextEditingController _preisController = TextEditingController();

  @override
  void dispose() {
    _leistungController.dispose();
    _mengeController.dispose();
    _measurementController.dispose();
    _preisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: SizedBox(
          height: 300,
          child: Card(
            color: const Color.fromARGB(255, 255, 255, 255),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _leistungController,
                          decoration: InputDecoration(
                            hintText: 'Material',
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0),
                              borderRadius: BorderRadius.circular(
                                  12), // Consistent rounded corners when focused
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _mengeController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Menge',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.grey[200]!, width: 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0),
                              borderRadius: BorderRadius.circular(
                                  12), // Consistent rounded corners when focused
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _measurementController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Einheit',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.grey[200]!, width: 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0),
                              borderRadius: BorderRadius.circular(
                                  16), // Consistent rounded corners when focused
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _preisController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Preis/mengeneinheit',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.grey[200]!, width: 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0),
                              borderRadius: BorderRadius.circular(
                                  12), // Consistent rounded corners when focused
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Clear the input fields
                          _leistungController.clear();
                          _mengeController.clear();
                          _measurementController.clear();
                          _preisController.clear();
                          widget.onHideCard();

                          // Set isCardVisible to false to hide the card
                          // setState(() {
                          //   isCardVisible = false;
                          // });
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 26, vertical: 18),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
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
                          final menge = (_mengeController.text);
                          final measurement = _measurementController.text;
                          final preis = _preisController.text;
                          if (leistung.isNotEmpty &&
                              preis.isNotEmpty &&
                              measurement.isNotEmpty &&
                              menge.isNotEmpty) {
                            widget.onSave(leistung, menge, measurement, preis);
                            _leistungController.clear();
                            _mengeController.clear();
                            _measurementController.clear();
                            _preisController.clear();
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text(
                                    'Please fill all fields and ensure valid entries.'),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 26, vertical: 18),
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Speichern',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class RowData {
  final String title;
  // ignore: non_constant_identifier_names
  final String Menge;
  // ignore: non_constant_identifier_names
  final String Measurement;
  final String price;

  const RowData(
      {required this.title,
      // ignore: non_constant_identifier_names
      required this.Menge,
      // ignore: non_constant_identifier_names
      required this.Measurement,
      required this.price});
}

class EditableRow extends StatefulWidget {
  final String originalTitle;
  final String originalMenge;
  final String originalMeausrement;
  final String originalPrice;
  final VoidCallback onDelete;

  const EditableRow({
    super.key,
    required this.originalTitle,
    required this.originalMenge,
    required this.originalMeausrement,
    required this.originalPrice,
    required this.onDelete,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditableRowState createState() => _EditableRowState();
}

class _EditableRowState extends State<EditableRow> {
  late TextEditingController _titleController;
  late TextEditingController _mengeController;
  late TextEditingController _measurementController;
  late TextEditingController _priceController;
  late String currentTitle;
  late String currentPrice;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize all controllers here
    _titleController = TextEditingController(text: widget.originalTitle);
    _mengeController = TextEditingController(text: widget.originalMenge);
    _measurementController =
        TextEditingController(text: widget.originalMeausrement);

    // Initialize currentPrice before using it to set up _priceController
    currentPrice =
        widget.originalPrice; // Set currentPrice from widget's originalPrice
    _priceController = TextEditingController(text: currentPrice);

    // Listener for _priceController to append '€' if it's not already there
    _priceController.addListener(() {
      String text = _priceController.text;
      if (!text.endsWith('€') && text.isNotEmpty) {
        String newText = '$text€';
        _priceController.value = _priceController.value.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length - 1),
        );
      }
    });

    // Initialize currentTitle similar to how currentPrice was handled
    currentTitle = widget.originalTitle;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _mengeController.dispose();
    _measurementController.dispose();
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
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: const TextStyle(fontWeight: FontWeight.w600),
                readOnly: !isEditing,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _mengeController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: const TextStyle(fontWeight: FontWeight.w600),
                readOnly: !isEditing,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _measurementController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: const TextStyle(fontWeight: FontWeight.w600),
                readOnly: !isEditing,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: const TextStyle(fontWeight: FontWeight.w600),
                readOnly: !isEditing,
              ),
            ),
            IconButton(
              // Icon for saving changes. This should only be visible and functional if editing is enabled.
              icon: Icon(isEditing
                  ? Icons.save
                  : Icons
                      .edit), // Show save icon only if in editing mode, otherwise show edit icon
              onPressed: () {
                if (isEditing) {
                  setState(() {
                    // Save the current text field contents to the state
                    final newTitle = _titleController.text;
                    final newPrice = '${_priceController.text}€';
                    currentTitle = newTitle;
                    currentPrice = newPrice;
                    isEditing =
                        !isEditing; // Toggle editing mode off after saving
                  });
                } else {
                  setState(() {
                    isEditing =
                        !isEditing; // Toggle editing mode on if not already editing
                  });
                }
              },
            ),
            IconButton(
              // Icon to toggle editing or delete depending on the state.
              icon: Icon(isEditing
                  ? Icons.cancel
                  : Icons.delete), // Show cancel if editing, delete if not
              onPressed: () {
                setState(() {
                  if (isEditing) {
                    // If editing, cancel the edits and revert to the original
                    isEditing = !isEditing;
                    _titleController.text =
                        currentTitle; // Revert to original title
                    _priceController.text =
                        currentPrice; // Revert to original price
                  } else {
                    // If not editing, perform delete action
                    widget.onDelete();
                  }
                });
              },
            ),

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
