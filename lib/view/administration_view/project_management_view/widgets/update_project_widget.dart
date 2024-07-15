import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../constants/themes/app_color.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/project_models/project_entry_vm/project_entry_vm.dart';
import '../../../../models/project_models/projects_state_enum/project_state.dart';
import '../../../../provider/data_provider/project_provders/project_vm_provider.dart';
import '../../../shared_widgets/custom_datepicker_widget.dart';
import '../../../shared_widgets/custom_dropdown_button.dart';
import '../../../shared_widgets/custom_textfield_widget.dart';
import '../../../shared_widgets/error_message_widget.dart';
import '../../../shared_widgets/symetric_button_widget.dart';
import '../../../shared_widgets/waiting_message_widget.dart';

class UpdateProjectWidget extends ConsumerStatefulWidget {
  final ProjectEntryVM project;
  final Function()? onCancel;

  const UpdateProjectWidget(this.project, {super.key, this.onCancel});
  @override
  ConsumerState<UpdateProjectWidget> createState() => _EditProjectState();
}

class _EditProjectState extends ConsumerState<UpdateProjectWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.project.title;
    _startDateController.text = DateFormat('d.M.y').format(widget.project.start);
    _endDateController.text = DateFormat('d.M.y').format(widget.project.terminationDate);
    _descriptionController.text = widget.project.description ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ref.watch(projectVMProvider).isLoading
      ? const WaitingMessageWidget('Lade Projekt')
      : Container(
          margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width > 950
                  ? MediaQuery.of(context).size.width - 950
                  : MediaQuery.of(context).size.width * 0.00),
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: Card(
            elevation: 9,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // *  Project title
                  CustomTextfield(
                    title: 'Projektname',
                    controller: _titleController,
                    hintText: 'Projektname',
                  ),
                  //  * Project customer + project state
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomDropDown(
                          initalValue: ref.watch(projectVMProvider).editAbleProject!.customer,
                          title: 'Kunde',
                          hintText: 'Kunde Auswählen',
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
                          onChanged: (c) {
                            ref
                                .read(projectVMProvider.notifier)
                                .updateEditableEntry(newCustomer: c!);
                          },
                        ),
                      ),
                      CustomDropDown(
                        initalValue: ref.watch(projectVMProvider).editAbleProject!.state,
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
                          log(s.toString());
                          ref.read(projectVMProvider.notifier).updateEditableEntry(newState: s!);
                        },
                      ),
                    ],
                  ),
                  // *  Project beginning time picker + Project ending timepicker
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomDatePicker(
                          title: 'Start Datum',
                          initDate: widget.project.start,
                          controller: _startDateController,
                        ),
                      ),
                      CustomDatePicker(
                        title: 'End Datum',
                        initDate: widget.project.terminationDate,
                        controller: _endDateController,
                      )
                    ],
                  ),
                  //  * Project description + Buttons
                  _buildDescriptionAndButton(),
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
              onPressed: () => _updateAndUpload(),
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
                    onPressed: () => _updateAndUpload(),
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
  void _updateAndUpload() {
    log('${ref.watch(projectVMProvider).editAbleProject}');
    if (_startDateController.text.isNotEmpty && _endDateController.text.isNotEmpty) {
      final start = _startDateController.text.split('.').map((e) => int.parse(e)).toList();
      final end = _endDateController.text.split('.').map((e) => int.parse(e)).toList();
      ref.read(projectVMProvider.notifier).updateEditableEntry(
            newDescription: _descriptionController.text,
            newStart: DateTime(start[2], start[1], start[0]),
            newTermination: DateTime(end[2], end[1], end[0]),
            newTitle: _titleController.text,
          );
    }
    if (ref.watch(projectVMProvider.notifier).editAbleProject == null) {
      showDialog(
          context: context,
          builder: (context) =>
              const ErrorMessageWidget('Bitte füllen sie Alle Eingabefelder aus'));
      return;
    }
    log('${ref.watch(projectVMProvider).editAbleProject}');
    ref.read(projectVMProvider.notifier).updateProject().then((e) {
      Utilitis.showSnackBar(
          context, e ? 'Erfolgreich geänder' : 'Leider ist etwas schief gegangen');
      widget.onCancel;
    });
    return;
  }
}
