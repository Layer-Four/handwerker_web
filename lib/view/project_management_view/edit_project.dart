import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../customer_project_view/custom_project.dart';
import '../shared_view_widgets/symetric_button_widget.dart';

class AddNewProject extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final CustomeProject? project;

  const AddNewProject({super.key, required this.onSave, required this.onCancel, this.project});

  @override
  State<AddNewProject> createState() => _AddNewProjectState();
}

class _AddNewProjectState extends State<AddNewProject> {
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _customerNumberController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  String? kundenzuweisungOption;
  String? statusOption;

  @override
  void initState() {
    super.initState();
    if (widget.project != null) {
      _projectNameController.text = widget.project!.customer; // Assuming 'customer' is a field in CustomeProject
    }
  }

  //dispose of controllers
  @override
  void dispose() {
    _projectNameController.dispose();
    _secondNameController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    _customerNumberController.dispose();
    _telephoneController.dispose();
    _contactController.dispose();
    _dateStartController.dispose();
    _dateEndController.dispose();
    super.dispose(); // Always call super.dispose() last
  }

  Future<void> _selectDate(TextEditingController controller, BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Widget buildDateField({
    required TextEditingController controller,
    required String hintText,
    required BuildContext context,
  }) =>
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: TextFormField(
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
              borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
            ),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: const Icon(Icons.calendar_today), // Icon to indicate it's a date field
          ),
          readOnly: true, // Prevent keyboard from appearing
          onTap: () => _selectDate(controller, context), // Open date picker when the field is tapped
        ),
      );

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 8.0),
          child: Card(
            elevation: 9,
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              height: 400,
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(6),
                          child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 5),
                        buildTextField(
                          hintText: 'Project X',
                          controller: _projectNameController,
                          context: context,
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(
                            'Kundenzuweisung',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 5),
                        buildDropdown(
                          options: ['Kunde X', 'Firma GmbH', 'Stammkunde Y'],
                          selectedValue: kundenzuweisungOption,
                          onChanged: (value) {
                            setState(() {
                              kundenzuweisungOption = value;
                            });
                          },
                          context: context,
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(
                            'Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 5),
                        buildDropdown(
                          options: ['Offen', 'Geschlossen', 'In Bearbeitung', 'On Hold'],
                          selectedValue: statusOption,
                          onChanged: (value) {
                            setState(() {
                              statusOption = value;
                            });
                          },
                          context: context,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('Beschreibung', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 2, // Allows the text field to expand to 7 lines.
                        minLines: 2, // Ensures the text field always shows 7 lines.
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 220, 217, 217),
                            ),
                          ),
                          //  labelText: 'Beschreibung',
                          hintText: 'Beschreibung hier eingeben...',
                          border: const OutlineInputBorder(),
                          //   fillColor: Colors.grey[200],
                          // Optional: for better visibility.
                          //   filled: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Zeitraum',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 5),
                      buildDateField(controller: _dateStartController, hintText: 'Startdatum', context: context),
                      const SizedBox(height: 5),
                      buildDateField(controller: _dateEndController, hintText: 'Enddatum', context: context),
                      const Spacer(),
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
                  ))
                ],
              ),
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
              borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
            ),
          ),
        ),
      ),
    );

Widget buildDropdown({
  required List<String> options,
  required String? selectedValue,
  required ValueChanged<String?> onChanged,
  required BuildContext context,
}) =>
    Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          hintText: 'Select option',
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
            borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: onChanged,
        items: options
            .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
            .toList(),
      ),
    );
