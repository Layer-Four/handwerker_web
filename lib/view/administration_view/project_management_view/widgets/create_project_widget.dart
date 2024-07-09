import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../constants/themes/app_color.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/customer_models/customer_short_model/customer_short_dm.dart';
import '../../../../models/project_models/project_entry_dm/project_entry_dm.dart';
import '../../../../provider/data_provider/project_provders/project_vm_provider.dart';
import '../../../shared_widgets/symetric_button_widget.dart';

class CreateProjectWidget extends ConsumerStatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const CreateProjectWidget({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

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
  ConsumerState<CreateProjectWidget> createState() => _EditProjectState();
}

class _EditProjectState extends ConsumerState<CreateProjectWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  ProjectEntryDM _project = const ProjectEntryDM();
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
    getCustomers();
    // if (widget.projectEntryVM != null) {
    //   _project = widget.projectEntryVM!;
    //   _titleController.text = _project.title ?? '';
    //   _dateStartController.text = _project.dateOfStart != null
    //       ? DateFormat('d.M.y').format(DateTime.parse(_project.dateOfStart!))
    //       : '';
    //   _dateEndController.text = _project.dateOfTermination != null
    //       ? DateFormat('d.M.y').format(DateTime.parse(_project.dateOfTermination!))
    //       : '';
    //   _descriptionController.text = _project.description ?? '';
    // }
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

  Future<void> getCustomers() async {
    final x = await ref.read(projectVMProvider.notifier).fetchCustomer();
    setState(() {
      customerOptions = x;
      isLoadingCustomers = false;
    });
  }

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
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(6),
          elevation: 3,
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
                    decoration: Utilitis.textFieldDecoration('Projektüberschrift'),
                    // const InputDecoration(
                    //   labelText: 'Projektüberschrift',
                    // ),
                    // onChanged: (value) {
                    //   setState(() {
                    //     _nameController.text = value;
                    //   }
                    //   );
                    // },
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
                  ),
                ),

                // End Date
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: buildDateField(
                    controller: _dateEndController,
                    hintText: 'End Datum',
                  ),
                ),

                // Description
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                    height: 80,
                    child: TextFormField(
                      controller: _descriptionController,
                      expands: true,
                      decoration: Utilitis.textFieldDecoration('Beschreibung'),
                      //   const InputDecoration(
                      //   labelText: 'Beschreibung',
                      // ),
                      maxLines: null, // Adjust max lines as needed
                      // onChanged: (value) {
                      //   setState(() {
                      //     _descriptionController.text = value;
                      //   });
                      // },
                    ),
                  ),
                ),

                // Save and Cancel Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SymmetricButton(
                        onPressed: widget.onCancel,
                        text: 'Abbrechen',
                        textStyle: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: AppColor.kPrimaryButtonColor),
                        color: AppColor.kWhite,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SymmetricButton(
                        onPressed: () => () {
                          _project = _project.copyWith(customerId: 1111);
                          log(_project.toJson().toString());
                        },
                        // onPressed: () => _saveProjectEntry(context),
                        text: 'Speichern',
                      ),
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
  }) =>
      TextFormField(
        controller: controller,
        decoration: Utilitis.textFieldDecoration(hintText),
        //  InputDecoration(
        //   hintText: hintText,
        //   hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //         color: AppColor.kTextfieldBorder,
        //       ),
        //   contentPadding: const EdgeInsets.symmetric(
        //     horizontal: 15,
        //     vertical: 5,
        //   ),
        //   enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(12),
        //     borderSide: BorderSide(
        //       color: AppColor.kTextfieldBorder,
        //     ),
        //   ),
        //   focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(12),
        //     borderSide: BorderSide(color: AppColor.kTextfieldBorder),
        //   ),
        //   filled: true,
        //   fillColor: Colors.white,
        //   suffixIcon: const Icon(Icons.calendar_today),
        // ),
        readOnly: true,
        onTap: () => _selectDate(controller, context),
      );

  Future<void> _selectDate(TextEditingController controller, BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: -1825)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        controller.text = DateFormat('d.M.y').format(picked);
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
