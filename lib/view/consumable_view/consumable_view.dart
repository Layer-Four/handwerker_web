import 'package:flutter/material.dart';
import '../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../shared_view_widgets/symetric_button_widget.dart';

class ConsumableBody extends StatefulWidget {
  const ConsumableBody({super.key});

  @override
  State<ConsumableBody> createState() => _ConsumableBodyState();
}

class _ConsumableBodyState extends State<ConsumableBody> {
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
          SnackBar(content: Text("Consumable added successfully")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error when adding consumable: ${e.toString()}")));
    }
  }

  int selectedIndex = -1;
  final TextEditingController _searchController = TextEditingController();
  late List<TextEditingController> _controllers;
  late List<bool> _isEditing;
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController measurmentController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool _isAddConsumableOpen = false;

  List<ConsumableVM> listOfConsumables = [
    ConsumableVM(
      measurement: Measurement.m,
      priceInCents: 3000,
      title: 'Montage Algemein',
      amount: 2,
    ),
    ConsumableVM(
      measurement: Measurement.m3,
      priceInCents: 9000000,
      title: 'Montage Fenster',
      amount: 2,
    ),
    ConsumableVM(
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
    throw const FormatException(
        'Invalid measurement title'); // More explicit error handling
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
    return SizedBox(
      width: contentWidth,
      height: contentHeight,
      child: Column(
        children: [
          _searchHeader(context),
          _tableHead(headStyle, contentWidth),
          SizedBox(
            width:
                contentWidth < 1000 ? contentWidth : (contentWidth / 10) * 7.5,
            height: contentHeight - 600,
            child: ListView.builder(
                itemCount: listOfConsumables.length,
                itemBuilder: (context, i) {
                  final item = listOfConsumables[i];
                  // Unique controller for each item
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                      ),
                    ),
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: (contentWidth / 10) * 1.7,
                          child: _isEditing[i]
                              ? TextField(
                                  // controller: _controllers[i],
                                  controller: titleController,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onSubmitted: (value) {
                                    _handleSave();
                                  },
                                )
                              : Text(item.title),
                        ),
                        SizedBox(
                          width: (contentWidth / 10) * 1.5,
                          child: _isEditing[i]
                              ? TextField(
                                  // controller: _controllers[i],
                                  controller: amountController,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onSubmitted: (value) {
                                    _handleSave();
                                  },
                                )
                              : Text('${item.amount}'),
                        ),
                        SizedBox(
                          width: (contentWidth / 10) * 1.5,
                          child: _isEditing[i]
                              ? TextField(
                                  // controller: _controllers[i],
                                  controller: measurmentController,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onSubmitted: (value) {
                                    _handleSave();
                                  },
                                )
                              : Text(item.measurement.getTitle()),
                        ),
                        SizedBox(
                          width: (contentWidth / 10) * 1.5,
                          child: _isEditing[i]
                              ? TextField(
                                  // controller: _controllers[i],
                                  controller: priceController,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onSubmitted: (value) {
                                    _handleSave();
                                  },
                                )
                              : Text('${item.priceInCents / 100} €'),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // Handle delete action here
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            print(
                                "Before toggle: _isEditing[$i] = ${_isEditing[i]}");

                            if (_isEditing[i]) {
                              _saveConsumableEdit(
                                  i); // This will save the current edits
                            } else {
                              setState(() {
                                selectedIndex =
                                    i; // Set selectedIndex to current item
                                _isEditing[i] =
                                    true; // Set this item as being edited
                                // Load current values into controllers
                                titleController.text =
                                    listOfConsumables[i].title;
                                amountController.text =
                                    listOfConsumables[i].amount.toString();
                                measurmentController.text =
                                    listOfConsumables[i].measurement.getTitle();
                                priceController.text =
                                    (listOfConsumables[i].priceInCents / 100)
                                        .toString();
                              });
                            }
                            print(
                                "After toggle: _isEditing[$i] = ${_isEditing[i]}");
                          },
                          icon: Icon(_isEditing[i] ? Icons.save : Icons.edit),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 80, vertical: 8.0),
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
                              _addNewConsumable(); // Add a new consumable when opening
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
          Visibility(
            visible: _isAddConsumableOpen,
            child: AddNewConsumable(
              onSave: () {
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
    );
  }

  void _addNewConsumable() {
    setState(() {
      final newController = TextEditingController();
      _controllers.add(newController);
      _isEditing.add(true);
    });
  }

  Padding _tableHead(TextStyle? headStyle, double contentWidth) => Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              width: (contentWidth / 10) * 1.2,
              child: Center(child: Text('Leistung', style: headStyle)),
            ),
            SizedBox(
              width: (contentWidth / 10) * 1.8,
              child: Center(child: Text('Menge', style: headStyle)),
            ),
            SizedBox(
              width: (contentWidth / 10) * 1.5,
              child: Center(child: Text('Einheit', style: headStyle)),
            ),
            Text(
              'Preis/mengeneinheit',
              style: headStyle,
            ),
          ],
        ),
      );

  Widget _searchHeader(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Row(
            children: [
              Text(
                '',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.orange),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100.0),
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        _searchController.text = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        suffixIcon: const Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}

class AddNewConsumable extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const AddNewConsumable({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 8.0),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('Leistung'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: SizedBox(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Leistung',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: const Color.fromARGB(
                                            255, 220, 217, 217),
                                      ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 5,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 220, 217, 217),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 220, 217, 217)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('Menge'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SizedBox(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Menge',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: const Color.fromARGB(
                                            255, 220, 217, 217),
                                      ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 5,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 220, 217, 217),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 220, 217, 217)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('Einheit'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SizedBox(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Einheit',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: const Color.fromARGB(
                                            255, 220, 217, 217),
                                      ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 5,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 220, 217, 217),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 220, 217, 217)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('Preis/mengeneinheit'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SizedBox(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Preis/mengeneinheit',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: const Color.fromARGB(
                                            255, 220, 217, 217),
                                      ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 5,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 220, 217, 217),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 220, 217, 217)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SymmetricButton(
                        color: const Color.fromARGB(255, 241, 241, 241),
                        text: 'Verwerfen',
                        style: const TextStyle(color: Colors.orange),
                        onPressed: onCancel,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SymmetricButton(
                        color: Colors.orange,
                        text: 'Speichern',
                        onPressed: onSave,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}



// import 'package:flutter/material.dart';
// import '../../models/consumable_models/consumable_vm/consumable_vm.dart';
// import '../shared_view_widgets/symetric_button_widget.dart';

// // Assume Measurement is an enum or class you've defined elsewhere.
// // enum Measurement { m, m3, x }

// class ConsumableBody extends StatefulWidget {
//   const ConsumableBody({Key? key}) : super(key: key);

//   @override
//   _ConsumableBodyState createState() => _ConsumableBodyState();
// }

// class _ConsumableBodyState extends State<ConsumableBody> {
//   List<ConsumableVM> listOfConsumables = [];
//   bool _isAddConsumableOpen = false;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize your consumable list here if needed
//     listOfConsumables = [
//       ConsumableVM(measurement: Measurement.m, priceInCents: 3000, title: 'Montage Algemein', amount: 2),
//       ConsumableVM(measurement: Measurement.m3, priceInCents: 9000000, title: 'Montage Fenster', amount: 2),
//       ConsumableVM(measurement: Measurement.x, priceInCents: 3000, title: 'Montage Algemeine Meister', amount: 20),
//     ];
//   }

//   void _addNewConsumable(ConsumableVM newConsumable) {
//     setState(() {
//       listOfConsumables.add(newConsumable);
//       _isAddConsumableOpen = false;  // Close the form
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Consumables")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: listOfConsumables.length,
//               itemBuilder: (context, index) {
//                 final item = listOfConsumables[index];
//                 return ListTile(
//                   title: Text(item.title),
//                   subtitle: Text("${item.amount} units, ${item.measurement.getTitle()}"),
//                 );
//               },
//             ),
//           ),
//           Visibility(
//             visible: _isAddConsumableOpen,
//             child: AddNewConsumable(
//               onSave: _addNewConsumable,
//               onCancel: () {
//                 setState(() {
//                   _isAddConsumableOpen = false;
//                 });
//               },
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 _isAddConsumableOpen = true;
//               });
//             },
//             child: Text("Add New Consumable"),
//           )
//         ],
//       ),
//     );
//   }
// }

// class AddNewConsumable extends StatelessWidget {
//   final Function(ConsumableVM) onSave;
//   final VoidCallback onCancel;

//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController measurementController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();

//   AddNewConsumable({
//     Key? key,
//     required this.onSave,
//     required this.onCancel,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: InputDecoration(labelText: 'Title'),
//             ),
//             TextField(
//               controller: amountController,
//               decoration: InputDecoration(labelText: 'Amount'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: measurementController,
//               decoration: InputDecoration(labelText: 'Measurement'),
//             ),
//             TextField(
//               controller: priceController,
//               decoration: InputDecoration(labelText: 'Price in Cents'),
//               keyboardType: TextInputType.number,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: onCancel,
//                   child: Text("Cancel"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     final newConsumable = ConsumableVM(
//                       title: titleController.text,
//                       amount: int.tryParse(amountController.text) ?? 0,
//                       measurement: Measurement.values.first, // Adjust as necessary
//                       priceInCents: int.tryParse(priceController.text) ?? 0,
//                     );
//                     onSave(newConsumable);
//                   },
//                   child: Text("Save"),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
