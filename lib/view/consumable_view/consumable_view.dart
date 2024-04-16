import 'package:flutter/material.dart';
import '../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../shared_view_widgets/symetric_button_widget.dart';

class ConsumableBody extends StatefulWidget {
  const ConsumableBody({super.key});

  @override
  State<ConsumableBody> createState() => _ConsumableBodyState();
}

class _ConsumableBodyState extends State<ConsumableBody> {
//   void addNewConsumable(ConsumableVM consumable) {
//   setState(() {
//     listOfConsumables.add(consumable);
//   });
// }

  void onSave() {
    try {
      int amount = int.parse(amountController.text);
      int priceInCents = int.parse(priceController.text) *
          100; // converting dollars/euros to cents, if necessary

      final newConsumable = ConsumableVM(
          title: titleController.text,
          measurement: parseMeasurement('assssss'),
          amount: amount,
          priceInCents: priceInCents);

      setState(() {
        listOfConsumables.add(newConsumable);
        _isAddConsumableOpen = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Consumable added successfully")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error when adding consumable: ${e.toString()}")));
    }
  }

  int selectedIndex = -1;
  // final TextEditingController _searchController = TextEditingController();
  late List<TextEditingController> _controllers;
  late List<bool> _isEditing;
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController measurmentController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool _isAddConsumableOpen = false;

  void addNewConsumable(ConsumableVM consumable) {
    setState(() {
      listOfConsumables.add(consumable);
    });
  }

  _showAddNewConsumableDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Consumable'),
          content: AddNewConsumable(
            onSave: (ConsumableVM newConsumable) {
              setState(() {
                listOfConsumables.add(newConsumable);
                Navigator.of(context).pop(); // Close the dialog
              });
            },
            onCancel: () {
              Navigator.of(context).pop(); // Just close the dialog
            },
          ),
        );
      },
    );
  }

  void _addNewConsumable() {
    setState(() {
      final newController = TextEditingController();
      _controllers.add(newController);
      _isEditing.add(true);
    });
  }

  List<ConsumableVM> listOfConsumables = [
    const ConsumableVM(
      measurement: Measurement.m,
      priceInCents: 3000,
      title: 'Montage Algemein',
      amount: 2,
    ),
    const ConsumableVM(
      measurement: Measurement.m3,
      priceInCents: 9000000,
      title: 'Montage Fenster',
      amount: 2,
    ),
    const ConsumableVM(
      measurement: Measurement.x,
      priceInCents: 3000,
      title: 'Montage Algemeine Meister',
      amount: 20,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    _controllers = List.generate(
        listOfConsumables.length, (index) => TextEditingController());
    // Initialize editing state
    _isEditing = List.generate(listOfConsumables.length, (_) => false);
    // Set initial text values for controllers
    for (int i = 0; i < listOfConsumables.length; i++) {
      _controllers[i].text = listOfConsumables[i].title;
    }
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    for (var controller in _controllers) {
      controller.dispose();
    }
    titleController.dispose();
    amountController.dispose();
    measurmentController.dispose();
    super.dispose();
  }

  Measurement parseMeasurement(String title) {
    for (var m in Measurement.values) {
      if (m.getTitle() == title) {
        return m;
      }
    }
    throw const FormatException('Invalid measurement title');
  }

  void _saveConsumableEdit(int index) {
    final newMeasurement = parseMeasurement(measurmentController.text);

    // Assuming other validations are successful
    setState(() {
      listOfConsumables[index] = ConsumableVM(
        title: titleController.text,
        amount: int.parse(amountController.text),
        measurement: newMeasurement,
        priceInCents: int.parse(priceController.text),
      );
      // Don't toggle _isEditing here since it's managed by _handleSave now
    });
  }

  void _handleSave() {
    if (selectedIndex != -1) {
      // Check for a valid index
      setState(() {
        _saveConsumableEdit(selectedIndex);
        _isEditing[selectedIndex] = false; // Set editing to false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final headStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(fontWeight: FontWeight.w600);
    final contentWidth = MediaQuery.of(context).size.width - 100;
    final contentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SizedBox(
      width: contentWidth,
      height: contentHeight,
      child: Column(
        children: [
          Container(
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Leistung',
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
                  Expanded(
                    child: Text(
                      'Einheit',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
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
                    width: 90,
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              ...listOfConsumables.map((consumable) {
                String priceFormatted =
                    '${consumable.priceInCents} Euro'; // Assuming price is in cents
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 14),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            consumable.title,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            consumable.amount.toString(),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            consumable.measurement.getTitle(),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            priceFormatted,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Add your edit functionality here
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Add your edit functionality here
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }), // Ensure you convert the iterable to a list
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 28),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Material(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(50),
                        child: Center(
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              _isAddConsumableOpen ? Icons.remove : Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isAddConsumableOpen = !_isAddConsumableOpen;
                                if (_isAddConsumableOpen) {
                                  _addNewConsumable(); // Trigger your addition logic
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: _isAddConsumableOpen,
            maintainSize: false,
            maintainAnimation: true,
            maintainState: true,
            child: AddNewConsumable(
              // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
              onSave: (ConsumableVM) {
                setState(() {
                  _addNewConsumable();
                });
              },
              onCancel: () {
                setState(() {
                  _isAddConsumableOpen = false;
                });
              },
            ),
          )
        ],
      ),
    ));
  }
}

class AddNewConsumable extends StatefulWidget {
  final Function(ConsumableVM) onSave; // Corrected to accept a ConsumableVM
  final VoidCallback onCancel;

  const AddNewConsumable({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AddNewConsumableState createState() => _AddNewConsumableState();
}

class _AddNewConsumableState extends State<AddNewConsumable> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final priceController = TextEditingController();
  Measurement selectedMeasurement =
      Measurement.m; // Assuming Measurement is an enum

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Card(
          elevation: 9,
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'Leistung',
                          hintText: 'Enter the title of the consumable',
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: amountController,
                        decoration: const InputDecoration(
                          labelText: 'Menge',
                          hintText: 'Enter the amount',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: priceController,
                        decoration: const InputDecoration(
                          labelText: 'Preis/mengeneinheit',
                          hintText: 'Enter the price per unit in cents',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Expanded(
                      child: DropdownButton<Measurement>(
                        isExpanded: true,
                        value: selectedMeasurement,
                        onChanged: (Measurement? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedMeasurement = newValue;
                            });
                          }
                        },
                        items:
                            Measurement.values.map((Measurement measurement) {
                          return DropdownMenuItem<Measurement>(
                            value: measurement,
                            child: Text(measurement.toString().split('.').last),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: widget.onCancel,
                      child: const Text('Verwerfen'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (titleController.text.isNotEmpty &&
                            amountController.text.isNotEmpty &&
                            priceController.text.isNotEmpty) {
                          try {
                            int amount = int.parse(amountController.text);
                            int priceCents =
                                int.parse(priceController.text) * 100;
                            ConsumableVM newConsumable = ConsumableVM(
                              title: titleController.text,
                              measurement: selectedMeasurement,
                              amount: amount,
                              priceInCents: priceCents,
                            );
                            widget.onSave(
                                newConsumable); // Capture the newConsumable
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Error: ${e.toString()}')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please fill all fields')));
                        }
                      },
                      child: const Text('Speichern'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
