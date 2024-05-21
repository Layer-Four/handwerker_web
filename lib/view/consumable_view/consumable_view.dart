import 'package:flutter/material.dart';


import '../shared_view_widgets/search_line_header.dart';

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
    //const RowData(title: 'Montage Allgemein', Menge: '2', Measurement: 'm', price: '120€'),
    //const RowData(title: 'Montage Fenster', Menge: '6', Measurement: 'cm', price: '80€'),
    //const RowData(title: 'Montage Allgemein Meister', Menge: '7', Measurement: 'm3', price: '540€'),
    const RowData(title: 'Kupferrohr', Menge: '100', Measurement: 'Meter', price: '1000 €'),
    const RowData(title: 'Wandfarbe', Menge: '10', Measurement: 'Liter', price: '60 €'),
    const RowData(title: 'Eichenholz', Menge: '1', Measurement: 'm3', price: '800 €'),
    const RowData(title: 'Dachziegel', Menge: '1', Measurement: 'm2', price: '30 €'),
    const RowData(title: 'Keramikfliesen', Menge: '1', Measurement: 'm2', price: '27 €'),
    const RowData(title: 'Rindenmulch', Menge: '100', Measurement: 'Liter', price: '30 €'),
    const RowData(title: 'kl. Nägel', Menge: '1000', Measurement: 'Stück', price: '10 €'),
    const RowData(title: 'gr. Nägel', Menge: '500', Measurement: 'Stück', price: '7 €'),
  ];

  bool isCardVisible = false;

  void hideCard() {
    setState(() {
      isCardVisible = false;
    });
  }

  void removeRow(RowData row) {
    setState(() {
      rowDataList.remove(row); // Remove the specified row
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(75, 30, 30, 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchLineHeader(title: 'Material'),
                /*                Padding(
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
                  ),*/
                const SizedBox(height: 44),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('Material', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 22),
                    Expanded(
                      child: Text('Menge', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 44),
                    Expanded(
                      child: Text('Einheit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    // SizedBox(width: 30),
                    Expanded(
                      child: Text('Preis/mengeneinheit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 110)
                  ],
                ),
                for (int i = 0; i < rowDataList.length; i++)
                  EditableRow(
                    originalTitle: rowDataList[i].title,
                    originalMenge: rowDataList[i].Menge,
                    originalMeasurement: rowDataList[i].Measurement,
                    originalPrice: rowDataList[i].price,
                    onDelete: () => removeRow(rowDataList[i]),
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
                        borderRadius: BorderRadius.circular(50), // Fully rounded corners
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isCardVisible = !isCardVisible;
                          });
                        },
                        iconSize: 30,
                        // Adjust the size of the icon if necessary
                        padding: EdgeInsets.zero,
                        // Remove any default padding to ensure centering
                        alignment: Alignment.center,
                        // Ensure the icon is centered in the button
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
      rowDataList.add(RowData(title: title, Menge: menge, Measurement: measurement, price: price));
    });
  }
}

class CardWidget extends StatefulWidget {
  final Function(String title, String menge, String measurement, String price) onSave;
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
  Widget build(BuildContext context) => SizedBox(
        width: double.maxFinite,
        height: 350,
        child: Card(
          surfaceTintColor: Colors.white,
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Material',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _leistungController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color.fromARGB(211, 245, 241, 241),
                                  // Background color
                                  hintText: 'Material',
                                  contentPadding: const EdgeInsets.all(8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none, // No border for normal state
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none, // Optional, defines border when field is enabled
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none, // Optional, defines border when field is disabled
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text('Menge', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _mengeController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color.fromARGB(211, 245, 241, 241),
                                  // Background color
                                  hintText: 'Menge',
                                  contentPadding: const EdgeInsets.all(8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none, // No border for normal state
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none, // Optional, defines border when field is enabled
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none, // Optional, defines border when field is disabled
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text('Einheit', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _measurementController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color.fromARGB(211, 245, 241, 241),
                                  // Background color
                                  hintText: 'Einheit',
                                  contentPadding: const EdgeInsets.all(8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none, // No border for normal state
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none, // Optional, defines border when field is enabled
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none, // Optional, defines border when field is disabled
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 30),
                        Flexible(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text('Preis/mengeneinheit',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _preisController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color.fromARGB(211, 245, 241, 241),
                                  // Background color
                                  hintText: 'Preis/mengeneinheit',
                                  contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none, // No border for normal state
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none, // Optional, defines border when field is enabled
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none, // Optional, defines border when field is disabled
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
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
                          final menge = _mengeController.text;
                          final meausurement = _measurementController.text;
                          final preis = _preisController.text;
                          if (leistung.isNotEmpty && menge.isNotEmpty && meausurement.isNotEmpty && preis.isNotEmpty) {
                            widget.onSave(leistung, menge, meausurement, preis);
                            _leistungController.clear();
                            _measurementController.clear();
                            _mengeController.clear();
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
              ],
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
  final String originalMeasurement;
  final String originalPrice;
  final VoidCallback onDelete;

  const EditableRow({
    super.key,
    required this.originalTitle,
    required this.originalMenge,
    required this.originalMeasurement,
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

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.originalTitle);
    _mengeController = TextEditingController(text: widget.originalMenge);
    _measurementController = TextEditingController(text: widget.originalMeasurement);
    _priceController = TextEditingController(text: widget.originalPrice);
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
              readOnly: !isEditing,
            )),
            Expanded(
                child: TextField(
              controller: _mengeController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              readOnly: !isEditing,
            )),
            Expanded(
              child: TextField(
                controller: _measurementController,
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
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              readOnly: !isEditing,
            )),

            // const Spacer(),
            // if (isEditing) // Only show the cancel icon if isEditing is true
            Visibility(
              visible: isEditing,
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              child: IconButton(
                icon: Icon(isEditing ? Icons.save : Icons.edit),
                onPressed: () {
                  setState(() {
                    if (isEditing) {
                      // Save the current text field contents
                      isEditing = false;
                    } else {
                      isEditing = true; // Enter editing mode
                    }
                  });
                },
              ),
            ),
          ],
        ),
      );
}
