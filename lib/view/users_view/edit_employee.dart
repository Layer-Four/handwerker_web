import 'package:flutter/material.dart';

import '../customer_project_view/custom_project.dart';
import '../shared_view_widgets/symetric_button_widget.dart';

class AddNewEmployee extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final CustomeProject? project;

  const AddNewEmployee(
      {super.key, required this.onSave, required this.onCancel, this.project});

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends State<AddNewEmployee> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _housenumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _customerNumberController =
      TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.project != null) {
      _firstNameController.text = widget.project!
          .customer; // Assuming 'customer' is a field in CustomeProject
    }
  }

  //dispose of controllers
  @override
  void dispose() {
    _firstNameController.dispose();
    _secondNameController.dispose();
    _streetController.dispose();
    _housenumberController.dispose();
    _cityController.dispose();
    _postNumberController.dispose();
    _emailController.dispose();
    _customerNumberController.dispose();
    _telephoneController.dispose();
    _contactController.dispose();
    super.dispose(); // Always call super.dispose() last
  }

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
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('Name',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          buildTextField(
                            hintText: 'Jürgen',
                            controller: _firstNameController,
                            context: context,
                          ),
                          const SizedBox(height: 5),
                          buildTextField(
                            hintText: 'Mustermann',
                            controller: _secondNameController,
                            context: context,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('Addresse',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                //    height: 100,
                                width: 300,
                                child: buildTextField(
                                  hintText: 'Mustermannstraße',
                                  controller: _streetController,
                                  context: context,
                                ),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                //      height: 100,
                                width: 100,
                                child: buildTextField(
                                  hintText: '3',
                                  controller: _housenumberController,
                                  context: context,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(
                                //    height: 100,
                                width: 300,
                                child: buildTextField(
                                  hintText: 'Berlin',
                                  controller: _cityController,
                                  context: context,
                                ),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                //    height: 100,
                                width: 100,
                                child: buildTextField(
                                  hintText: '11234',
                                  controller: _postNumberController,
                                  context: context,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'Sonstiges',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          buildTextField(
                            hintText: 'Email',
                            controller: _emailController,
                            context: context,
                          ),
                          const SizedBox(height: 10),
                          buildTextField(
                            hintText: 'Telefon',
                            controller: _customerNumberController,
                            context: context,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(''),
                          ),
                          buildTextField(
                            hintText: 'Kundennummer',
                            controller: _telephoneController,
                            context: context,
                          ),
                          const SizedBox(height: 10),
                          buildTextField(
                            hintText: 'Kontaktperson',
                            controller: _contactController,
                            context: context,
                          ),
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
                        onPressed: () {
                          widget.onCancel();
                          //Dispose of controllers
                          //     dispose();
                        }, //onCancel
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SymmetricButton(
                        color: Colors.orange,
                        text: 'Speichern',
                        onPressed: widget.onSave,
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

Widget buildTextField({
  required String hintText,
  required TextEditingController controller,
  required BuildContext context,
}) =>
    SizedBox(
      // height: 100,
      //width: 200,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color.fromARGB(255, 220, 217, 217),
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
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
            ),
          ),
        ),
      ),
    );
