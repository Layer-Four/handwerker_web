import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../constants/api/api.dart';
import '../../../../constants/themes/app_color.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/customer_models/customer_short_model/customer_short_dm.dart';
import '../../../../models/project_entry_models/project_entry_vm/project_entry_vm.dart';
import '../../../../models/project_models/customer_projekt_model/custom_project.dart';
import '../mutableprojectentryvm.dart';

class EditProject extends ConsumerStatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final CustomeProject? project;
  final ProjectEntryVM projectEntryVM;
  late final MutableProjectEntryVM mutableProjectEntryVM;

  EditProject({
    super.key,
    required this.onSave,
    required this.onCancel,
    this.project,
    required this.projectEntryVM,
  }) {
    mutableProjectEntryVM = MutableProjectEntryVM.fromProjectEntryVM(projectEntryVM);
  }

  factory EditProject.withDefaultVM({
    Key? key,
    required VoidCallback onSave,
    required VoidCallback onCancel,
    required CustomeProject? project,
    ProjectEntryVM? projectEntryVM,
  }) =>
      EditProject(
        key: key,
        onSave: onSave,
        onCancel: onCancel,
        project: project,
        projectEntryVM: projectEntryVM ?? const ProjectEntryVM(),
      );

  @override
  ConsumerState<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends ConsumerState<EditProject> {
  late TextEditingController _nameController;
  late TextEditingController _dateStartController;
  late TextEditingController _dateEndController;
  late TextEditingController _descriptionController;
  String? selectedCustomer;
  String? selectedStatus;
  List<CustomerShortDM> customerOptions = [];
  List<String> statusOptions = ['Offen', 'Geschlossen', 'In Bearbeitung', 'On Hold'];
  final Map<String, int> statusOptionsMap = {
    'Offen': 3,
    'Geschlossen': 5,
    'In Bearbeitung': 6,
    'On Hold': 7,
  };
  bool isLoadingCustomers = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.projectEntryVM.title ?? '');
    _dateStartController = TextEditingController(
        text: widget.projectEntryVM.dateOfStart != null
            ? DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.projectEntryVM.dateOfStart!))
            : '');
    _dateEndController = TextEditingController(
        text: widget.projectEntryVM.dateOfTermination != null
            ? DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(widget.projectEntryVM.dateOfTermination!))
            : '');
    _descriptionController = TextEditingController(text: widget.projectEntryVM.description ?? '');
    fetchCustomers();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateStartController.dispose();
    _dateEndController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> fetchCustomers() async {
    try {
      final response = await Api().getListCustomer;
      final List<dynamic> data = response.data;
      setState(() {
        customerOptions = data.map((json) => CustomerShortDM.fromJson(json)).toList();
        isLoadingCustomers = false;
      });
    } catch (e) {
      setState(() {
        isLoadingCustomers = false;
      });
      // Handle the error appropriately
    }
  }

  Future<void> _saveProjectEntry(BuildContext context) async {
    CustomerShortDM? selectedCustomerObject = customerOptions.firstWhere(
      (customer) => customer.companyName == selectedCustomer,
      orElse: () => CustomerShortDM(companyName: 'Standardunternehmen', id: -1),
    );

    int? selectedStatusId = statusOptionsMap[selectedStatus];

    ProjectEntryVM newProjectEntry = ProjectEntryVM(
      title: _nameController.text,
      dateOfStart: _dateStartController.text,
      dateOfTermination: _dateEndController.text,
      projectStatusId: selectedStatusId,
      customerId: selectedCustomerObject.id,
      description: _descriptionController.text,
    );

    try {
      if (widget.project == null) {
        // Creating a new project
        final Map<String, dynamic> projectEntryMap = newProjectEntry.toJson();
        await Api().postCreateProjectEntry(projectEntryMap);
      } else {
        // Updating an existing project
        widget.mutableProjectEntryVM = MutableProjectEntryVM(
          title: _nameController.text,
          dateOfStart: _dateStartController.text,
          dateOfTermination: _dateEndController.text,
          projectStatusId: selectedStatusId ?? 0,
          customerId: selectedCustomerObject.id,
          description: _descriptionController.text,
        );

        final Map<String, dynamic> projectEntryMap =
            widget.mutableProjectEntryVM.toProjectEntryVM().toJson();
        await Api().putUpdateProjectEntry(projectEntryMap);
      }
      widget.onSave();
    } catch (e) {
      log('Error: $e');
      // Handle errors if necessary
      // ignore: use_build_context_synchronously
      Utilitis.showSnackBar(context, 'Projektspeicherung fehlgeschlagen: $e');
    }
  }

  @override
  Widget build(BuildContext context) => Dialog(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Project Title
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Projektüberschrift',
                    ),
                    onChanged: (value) {
                      setState(() {
                        //_nameController.text = value;
                      });
                    },
                  ),
                ),

                // Kundenzuweisung (Customer Selection)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: buildDropdown(
                    options: customerOptions.map((customer) => customer.companyName).toList(),
                    selectedValue: selectedCustomer,
                    onChanged: (value) {
                      setState(() {
                        selectedCustomer = value;
                      });
                    },
                    context: context,
                    hintText: 'Kunden auswählen',
                  ),
                ),

                // Status
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: buildDropdown(
                    options: statusOptions,
                    selectedValue: selectedStatus,
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                    },
                    context: context,
                    hintText: 'Status auswählen',
                  ),
                ),

                // Start Date
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: buildDateField(
                    controller: _dateStartController,
                    hintText: 'Start Datum',
                    context: context,
                  ),
                ),

                // End Date
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: buildDateField(
                    controller: _dateEndController,
                    hintText: 'End Datum',
                    context: context,
                  ),
                ),

                // Description
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Beschreibung',
                    ),
                    maxLines: 3, // Adjust max lines as needed
                    onChanged: (value) {
                      setState(() {
                        _descriptionController.text = value;
                      });
                    },
                  ),
                ),

                // Save and Cancel Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: widget.onCancel,
                      child: const Text('Abbrechen'),
                    ),
                    ElevatedButton(
                      onPressed: () => _saveProjectEntry(context),
                      child: const Text('Speichern'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildDateField({
    required TextEditingController controller,
    required String hintText,
    required BuildContext context,
  }) =>
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColor.kTextfieldBorder,
              ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColor.kTextfieldBorder,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.kTextfieldBorder),
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        readOnly: true,
        onTap: () => _selectDate(controller, context),
      );

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

  Widget buildDropdown({
    required List<String?> options,
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
    required BuildContext context,
    required String hintText,
  }) {
    final uniqueOptions = options.toSet().toList();

    return DropdownButtonFormField<String?>(
      value: selectedValue,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColor.kTextfieldBorder,
            ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColor.kTextfieldBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.kTextfieldBorder),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: onChanged,
      items: uniqueOptions
          .map<DropdownMenuItem<String?>>((String? value) => DropdownMenuItem<String?>(
                value: value,
                child: Text(value ?? ''),
              ))
          .toList(),
    );
  }
}
