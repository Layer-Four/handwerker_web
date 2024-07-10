import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer';

import '../../../../constants/themes/app_color.dart';
import '../../../../models/customer_models/customer_short_model/customer_short_dm.dart';
import '../../../../models/project_models/project_entry_vm/project_entry_vm.dart';
import '../../../../provider/data_provider/project_provders/project_vm_provider.dart';
import 'mutableprojectentryvm.dart';
import '../../../../models/project_entry_models/project_entry_vm/project_entry_vm.dart';
import '../../../../models/project_models/customer_projekt_model/custom_project.dart';
import '../mutableprojectentryvm.dart';
import '../../../shared_widgets/symetric_button_widget.dart';

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
    _nameController = TextEditingController(text: widget.projectEntryVM.title ?? '');
    _dateStartController = TextEditingController(
        text: widget.projectEntryVM.dateOfStart != null
            ? DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.projectEntryVM.dateOfStart!))
            : '');
    _dateEndController = TextEditingController(
        text: widget.projectEntryVM.dateOfTermination != null
            ? DateFormat('dd-MM-yyyy')
                .format(DateTime.parse(widget.projectEntryVM.dateOfTermination!))
            : '');
    _descriptionController = TextEditingController(text: widget.projectEntryVM.description ?? '');
    fetchCustomers();
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
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width > 900 ? 900 : MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
        child: Card(
          elevation: 9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('Projektüberschrift',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          buildTextField(
                            hintText: 'Projektüberschrift',
                            controller: _nameController,
                            context: context,
                          ),
                          const SizedBox(height: 5),
                          buildDropdown(
                            options: customerOptions
                                .map((customer) => customer.companyName)
                                .where((name) => name != null)
                                .cast<String>()
                                .toList(),
                            selectedValue: selectedCustomer,
                            onChanged: (value) {
                              setState(() {
                                selectedCustomer = value;
                              });
                            },
                            context: context,
                            hintText: 'Kunden auswählen',
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          buildDropdown(
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
                          const SizedBox(height: 5),
                          buildDateField(
                            controller: _dateStartController,
                            hintText: 'Start Datum',
                            context: context,
                          ),
                          const SizedBox(height: 5),
                          buildDateField(
                            controller: _dateEndController,
                            hintText: 'End Datum',
                            context: context,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'Beschreibung',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          buildTextField(
                            hintText: 'Beschreibung',
                            controller: _descriptionController,
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
                        text: 'Verwerfen',
                        textStyle: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: AppColor.kPrimaryButtonColor),
                        color: AppColor.kWhite,
                        onPressed: widget.onCancel,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SymmetricButton(
                        text: 'Speichern',
                        onPressed: () => _saveProjectEntry(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildTextField({
    required String hintText,
    required TextEditingController controller,
    required BuildContext context,
  }) =>
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: TextField(
          controller: controller,
          decoration: EditProject.textFieldDecoration(hintText), // Utilize textFieldDecoration here
        ),
      );

  Widget buildDropdown({
    required List<String> options,
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
    required BuildContext context,
    required String hintText,
  }) =>
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.kTextfieldColor, // Set background color here
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButton<String>(
              value: selectedValue,
              hint: Text(hintText, style: const TextStyle(color: Colors.black38)),
              isExpanded: true,
              underline: Container(),
              onChanged: onChanged,
              items: options.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      );

  Widget buildDateField({
    required TextEditingController controller,
    required String hintText,
    required BuildContext context,
  }) =>
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.kTextfieldColor,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black38),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(color: Colors.white),
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
