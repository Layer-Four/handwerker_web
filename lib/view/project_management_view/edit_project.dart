import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

import '../customer_project_view/custom_project.dart';
import '../shared_view_widgets/symetric_button_widget.dart';
import 'package:handwerker_web/models/project_entry_models/project_entry_vm/project_entry_vm.dart';
import 'package:handwerker_web/constants/api/api.dart';

class AddNewProject extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final CustomeProject? project;
  final ProjectEntryVM projectEntryVM;

  const AddNewProject({
    Key? key,
    required this.onSave,
    required this.onCancel,
    this.project,
    required this.projectEntryVM,
  }) : super(key: key);

  factory AddNewProject.withDefaultVM({
    Key? key,
    required VoidCallback onSave,
    required VoidCallback onCancel,
    required CustomeProject? project,
    ProjectEntryVM? projectEntryVM, // Change to nullable
  }) {
    return AddNewProject(
      key: key,
      onSave: onSave,
      onCancel: onCancel,
      project: project,
      projectEntryVM:
          projectEntryVM ?? ProjectEntryVM(), // Use default value if null
    );
  }

  @override
  State<AddNewProject> createState() => _AddNewProjectState();
}

class _AddNewProjectState extends State<AddNewProject> {
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _customerNumberController =
      TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  String? selectedProject;
  String? selectedCustomer;
  String? selectedStatus;
  List<Customer> customerOptions = [];
  List<String> statusOptions = [
    'Offen',
    'Geschlossen',
    'In Bearbeitung',
    'On Hold'
  ];
  List<Project> projectOptions = [];
  bool isLoadingCustomers = true;
  bool isLoadingProjects = true;
  late ProjectEntryVM _projectEntryVM;

  @override
  void initState() {
    super.initState();
    fetchProjects();
    fetchCustomers();
    _projectEntryVM = ProjectEntryVM();
  }

  Future<void> fetchProjects() async {
    setState(() {
      isLoadingProjects = true;
    });
    try {
      final response = await Api().getListProject;
      final List<dynamic> data = response.data;
      setState(() {
        projectOptions = data.map((json) => Project.fromJson(json)).toList();
        isLoadingProjects = false;
      });
    } catch (e) {
      setState(() {
        isLoadingProjects = false;
      });
      // Handle the error appropriately
    }
  }

  Future<void> fetchCustomers() async {
    setState(() {
      isLoadingCustomers = true;
    });
    try {
      final response = await Api().getListCustomer;
      final List<dynamic> data = response.data;
      setState(() {
        customerOptions = data.map((json) => Customer.fromJson(json)).toList();
        isLoadingCustomers = false;
      });
    } catch (e) {
      setState(() {
        isLoadingCustomers = false;
      });
      // Handle the error appropriately
    }
  }

  Future<void> _saveProjectEntry() async {
    // Find the selected Customer object based on the selected company name
    Customer selectedCustomerObject = customerOptions.firstWhere(
      (customer) => customer.companyName == selectedCustomer,
      orElse: () => Customer(companyName: 'Unknown', id: -1),
    );

    // Create a new ProjectEntryVM object with the entered data
    ProjectEntryVM newProjectEntry = ProjectEntryVM(
      title: selectedProject,
      dateOfStart: _dateStartController.text,
      dateOfTermination: _dateEndController.text,
      customerId: selectedCustomerObject?.id,
      description: _descriptionController.text,
      projectStatusId: _projectEntryVM.projectStatusId,
    );

    try {
      // Call the API to create the project entry
      await Api().postCreateProjectEntry(newProjectEntry);

      // Call the onSave callback provided by the parent widget
      widget.onSave();
    } catch (e) {
      // Handle errors if necessary
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _secondNameController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    _customerNumberController.dispose();
    _telephoneController.dispose();
    _contactController.dispose();
    _dateStartController.dispose();
    _dateEndController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      TextEditingController controller, BuildContext context) async {
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
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
            ),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          readOnly: true,
          onTap: () => _selectDate(controller, context),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(6),
                          child: Text('Name',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 5),
                        buildDropdown(
                          options: projectOptions
                              .map((project) => project.title ?? '')
                              .toList(),
                          selectedValue: selectedProject,
                          onChanged: (value) {
                            setState(() {
                              selectedProject = value;
                            });
                          },
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
                        isLoadingCustomers
                            ? Center(child: CircularProgressIndicator())
                            : buildDropdown(
                                options: customerOptions
                                    .map((customer) =>
                                        customer.companyName ?? '')
                                    .toList(),
                                selectedValue: selectedCustomer,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCustomer = value;
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
                          options: statusOptions,
                          selectedValue: selectedStatus,
                          onChanged: (value) {
                            setState(() {
                              selectedStatus = value;
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
                        child: Text('Beschreibung',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      TextField(
                        controller: _descriptionController,
                        maxLines:
                            2, // Allows the text field to expand to 7 lines.
                        minLines:
                            2, // Ensures the text field always shows 7 lines.
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
                      buildDateField(
                          controller: _dateStartController,
                          hintText: 'Startdatum',
                          context: context),
                      const SizedBox(height: 5),
                      buildDateField(
                          controller: _dateEndController,
                          hintText: 'Enddatum',
                          context: context),
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
                              onPressed: _saveProjectEntry,
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
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
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
}) {
  // Remove duplicates from the list of options
  options = options.toSet().toList();

  return Padding(
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
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: onChanged,
      items: options
          .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
          .toList(),
    ),
  );
}
