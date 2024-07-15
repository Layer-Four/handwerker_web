import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/themes/app_color.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/project_models/projects_state_enum/project_state.dart';
import '../../../../provider/data_provider/project_provders/project_vm_provider.dart';
import '../../../shared_widgets/custom_datepicker_widget.dart';
import '../../../shared_widgets/custom_dropdown_button.dart';
import '../../../shared_widgets/custom_textfield_widget.dart';
import '../../../shared_widgets/symetric_button_widget.dart';

class CreateProjectWidget extends ConsumerStatefulWidget {
  final void Function() onCancel;

  const CreateProjectWidget({super.key, required this.onCancel});

  @override
  ConsumerState<CreateProjectWidget> createState() => _EditProjectState();
}

class _EditProjectState extends ConsumerState<CreateProjectWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 9,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Project Title
                CustomTextfield(
                  title: 'Projektname',
                  controller: _titleController,
                  hintText: 'Benenne dein Projekt',
                ),

                // Kundenzuweisung (Customer Selection)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CustomDropDown(
                        initalValue: ref.watch(projectVMProvider).editAbleProject?.customer,
                        title: 'Kunde',
                        hintText: 'Kunden auswählen',
                        items: ref
                            .watch(projectVMProvider)
                            .customers
                            .map(
                              (c) => DropdownMenuItem(
                                value: c,
                                child: Text(c.companyName),
                              ),
                            )
                            .toList(),
                        onChanged: (c) => ref
                            .read(projectVMProvider.notifier)
                            .updateEditableEntry(newCustomer: c),
                      ),
                    ),
                    CustomDropDown(
                      initalValue: ref.watch(projectVMProvider).editAbleProject?.state,
                      title: 'Status',
                      hintText: 'Status auswählen',
                      items: ProjectStateExt.getProjectStates
                          .map(
                            (s) => DropdownMenuItem(
                              value: s,
                              child: Text(s.title),
                            ),
                          )
                          .toList(),
                      onChanged: (s) {
                        ref.read(projectVMProvider.notifier).updateEditableEntry(newState: s!);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CustomDatePicker(
                        title: 'Start Datum',
                        initDate: DateTime.now(),
                        controller: _startDateController,
                      ),
                    ),
                    CustomDatePicker(
                      title: 'End Datum',
                      initDate: DateTime.now().add(const Duration(days: 1)),
                      controller: _endDateController,
                    )
                  ],
                ),
                _buildDescriptionAndButton(),
                // Save and Cancel Buttons
              ],
            ),
          ),
        ),
      );

  Widget _buildDescriptionAndButton() => MediaQuery.of(context).size.width > 600
      ? Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CustomTextfield(
                title: 'Beschreibung',
                hintText: 'Beschreibung',
                controller: _descriptionController,
                isMultiLine: true,
                textfieldHeight: 90,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
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
            SymmetricButton(
              text: 'Speichern',
              onPressed: () => _updateAndCreateNewProject(),
              // onPressed: () => _saveProjectEntry(context),
            ),
          ],
        )
      : Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CustomTextfield(
                title: 'Beschreibung',
                hintText: 'Beschreibung',
                controller: _descriptionController,
                isMultiLine: true,
                textfieldHeight: 90,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SymmetricButton(
                    text: 'Speichern',
                    onPressed: () => _updateAndCreateNewProject(),
                    // onPressed: () => _saveProjectEntry(context),
                  ),
                ),
                SymmetricButton(
                  text: 'Verwerfen',
                  textStyle: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: AppColor.kPrimaryButtonColor),
                  color: AppColor.kWhite,
                  onPressed: widget.onCancel,
                ),
              ],
            ),
          ],
        );
  void _updateAndCreateNewProject() {
    log('${ref.watch(projectVMProvider).editAbleProject}');
    final start = _startDateController.text.split('.').map((e) => int.parse(e)).toList();
    final end = _endDateController.text.split('.').map((e) => int.parse(e)).toList();
    ref.read(projectVMProvider.notifier).updateEditableEntry(
          newDescription: _descriptionController.text,
          newStart: DateTime(start[2], start[1], start[0]),
          newTermination: DateTime(end[2], end[1], end[0]),
          newTitle: _titleController.text,
        );
    log('${ref.watch(projectVMProvider).editAbleProject}');

    ref.read(projectVMProvider.notifier).createProject().then((e) {
      widget.onCancel();
      Utilitis.showSnackBar(
        context,
        e ? 'Erfolgreich neues Projekt angelegt' : 'Leider ist etwas schief gegangen',
      );
    });
    return;
  }
}
