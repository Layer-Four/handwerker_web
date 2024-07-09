import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../constants/themes/app_color.dart';
import '../../../../models/customer_models/customer_short_model/customer_short_dm.dart';
import '../../../../models/project_models/project_entry_vm/project_entry_vm.dart';
import '../../../../provider/data_provider/project_provders/project_vm_provider.dart';
import 'mutableprojectentryvm.dart';

class UpdateProjectWidget extends ConsumerStatefulWidget {
  final ProjectEntryVM projectEntryVM;
  late final MutableProjectEntryVM mutableProjectEntryVM;

  UpdateProjectWidget(
    this.projectEntryVM, {
    super.key,
    // required this.onSave,
    // required this.onCancel,
  }) {
    // mutableProjectEntryVM = MutableProjectEntryVM.fromProjectEntryVM(projectEntryVM);
  }

  // factory EditProject.withDefaultVM({
  //   Key? key,
  //   required VoidCallback onSave,
  //   required VoidCallback onCancel,
  //   required CustomeProject? project,
  //   ProjectEntryVM? projectEntryVM,
  // }) =>
  //     EditProject(
  //       key: key,
  //       onSave: onSave,
  //       onCancel: onCancel,
  //       project: project,
  //       projectEntryVM: projectEntryVM ?? const ProjectEntryVM(),
  //     );

  @override
  ConsumerState<UpdateProjectWidget> createState() => _EditProjectState();
}

class _EditProjectState extends ConsumerState<UpdateProjectWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late ProjectEntryVM _project;
  late ProjectState _selectedStatus;
  late CustomerShortDM _selectedCustomer;
  // List<CustomerShortDM> customerOptions = [];
  // List<String> statusOptions = ['Offen', 'Geschlossen', 'In Bearbeitung', 'On Hold'];
  // final Map<String, int> statusOptionsMap = {
  //   'Offen': 3,
  //   'Geschlossen': 5,
  //   'In Bearbeitung': 6,
  //   'On Hold': 7,
  // };
  bool isLoadingCustomers = true;

  @override
  void initState() {
    // getCustomers();
    log('${widget.projectEntryVM}');
    _project = widget.projectEntryVM;
    _selectedCustomer = _project.customer!;
    _selectedStatus = _project.state;
    _titleController.text = _project.title;
    _dateStartController.text = DateFormat('d.M.y').format(_project.start);
    _dateEndController.text = DateFormat('d.M.y').format(_project.terminationDate);
    _descriptionController.text = _project.description ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateStartController.dispose();
    _dateEndController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Future<void> getCustomers() async {
  //   final x = await ref.read(projectVMProvider.notifier).fetchCustomer();
  //   setState(() {
  //     customerOptions = x;
  //     isLoadingCustomers = false;
  //   });
  // }

  // Future<void> _saveProjectEntry(BuildContext context) async {
  //   CustomerShortDM? selectedCustomerObject = customerOptions.firstWhere(
  //     (customer) => customer.companyName == selectedCustomer,
  //     orElse: () => CustomerShortDM(companyName: 'Standardunternehmen', id: -1),
  //   );

  //   int? selectedStatusId = statusOptionsMap[selectedStatus];

  //   ProjectEntryVM newProjectEntry = ProjectEntryVM(
  //     title: _titleController.text,
  //     dateOfStart: _dateStartController.text,
  //     dateOfTermination: _dateEndController.text,
  //     projectStatusId: selectedStatusId,
  //     customerId: selectedCustomerObject.id,
  //     description: _descriptionController.text,
  //   );

  //   try {
  //     if (widget.project == null) {
  //       // Creating a new project
  //       final Map<String, dynamic> projectEntryMap = newProjectEntry.toJson();
  //       await Api().postCreateProjectEntry(projectEntryMap);
  //     } else {
  //       // Updating an existing project
  //       widget.mutableProjectEntryVM = MutableProjectEntryVM(
  //         title: _titleController.text,
  //         dateOfStart: _dateStartController.text,
  //         dateOfTermination: _dateEndController.text,
  //         projectStatusId: selectedStatusId ?? 0,
  //         customerId: selectedCustomerObject.id,
  //         description: _descriptionController.text,
  //       );

  //       final Map<String, dynamic> projectEntryMap =
  //           widget.mutableProjectEntryVM.toProjectEntryVM().toJson();
  //       await Api().putUpdateProjectEntry(projectEntryMap);
  //     }
  //     widget.onSave();
  //   } catch (e) {
  //     log('Error: $e');
  //     // Handle errors if necessary
  //     // ignore: use_build_context_synchronously
  //     return Utilitis.showSnackBar(context, 'Projektspeicherung fehlgeschlagen: $e');
  //   }
  // }

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
                    controller: _titleController,
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
                    options: ref
                        .watch(projectVMProvider)
                        .customers
                        .map(
                          (e) => e.companyName,
                        )
                        .toList(),
                    // customerOptions.map((customer) => customer.companyName).toList(),
                    selectedValue: widget.projectEntryVM.customer!.companyName,
                    onChanged: (value) {
                      setState(() {
                        _selectedCustomer = ref
                            .watch(projectVMProvider)
                            .customers
                            .firstWhere((e) => e.companyName == value);
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
                    options: [
                      ProjectState.doing.title,
                      ProjectState.finished.title,
                      ProjectState.onHold.title,
                      ProjectState.start.title,
                    ],
                    selectedValue: _selectedStatus.title,
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = ProjectStateExt.getStateFromTitle(value!);
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
                      onPressed: () {},
                      // onPressed: widget.onCancel,
                      child: const Text('Abbrechen'),
                    ),
                    ElevatedButton(
                      onPressed: () => () {},
                      // onPressed: () => _saveProjectEntry(context),
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
          .map<DropdownMenuItem<String?>>((value) => DropdownMenuItem(
                value: value,
                child: Text(value ?? ''),
              ))
          .toList(),
    );
  }

  void updateProject() {
    _project = _project.copyWith(
        title: _titleController.text,
        start: DateTime.parse(_dateStartController.text),
        terminationDate: DateTime.parse(_dateEndController.text),
        state: _selectedStatus,
        description: _descriptionController.text,
        customer: _selectedCustomer);
  }
}
