import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:handwerker_web/models/project_entry_models/project_entry_vm/project_entry_vm.dart';
import 'package:handwerker_web/provider/data_provider/project_provders/project_vm_provider.dart';
import 'package:handwerker_web/constants/utilitis/utilitis.dart';
import 'package:handwerker_web/view/administration_view/project_management_view/project_managment_view.dart'; // Import your utility functions for dialogs, snackbar, etc.

import 'edit_project.dart'; // Import your EditProject widget here

class ProjectCard extends ConsumerStatefulWidget {
  final ProjectEntryVM project;
  final VoidCallback onDelete;
  final ValueChanged<ProjectEntryVM> onUpdate;

  const ProjectCard({
    Key? key,
    required this.project,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  @override
  ConsumerState<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectCard> {
  bool _showProjectDetails = false;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4.0),
    child: Material(
      borderRadius: BorderRadius.circular(6),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => setState(() {
              _showProjectDetails = !_showProjectDetails;
            }),
            child: Container(
              height: 69,
              padding: const EdgeInsets.only(left: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Tooltip(
                    message:
                    'Projekt: ${widget.project.title}\nStartdatum: ${widget.project.dateOfStart}\nEnddatum: ${widget.project.dateOfTermination}\nStatus: ${getStatusString(widget.project.projectStatusId)}\nKunde: ${getCustomerName(widget.project.customerId)}\nBeschreibung: ${widget.project.description}',
                    textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                    child: Text(
                      widget.project.title ?? '',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _showDeleteConfirmation(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => setState(() => _showProjectDetails = !_showProjectDetails),
                  ),
                ],
              ),
            ),
          ),
          _showProjectDetails ? _projectDetailsWindow(context) : const SizedBox.shrink(),
        ],
      ),
    ),
  );

  void _showDeleteConfirmation(BuildContext context) {
    Utilitis.askPopUp(
      context,
      message: 'Sind Sie sicher, dass Sie dieses Projekt löschen wollen?',
      onAccept: () {
        ref.read(projectVMProvider.notifier).deleteProject(widget.project.id ?? 0);

        // Assuming deleteProject does not return a Future
        Utilitis.showSnackBar(context, 'Projekt wurde erfolgreich gelöscht');
        widget.onDelete();

        Navigator.of(context).pop(); // Dismiss the dialog
      },
      onReject: () {
        Navigator.of(context).pop(); // Dismiss the dialog on reject
      },
    );
  }

  Widget _projectDetailsWindow(BuildContext context) => SizedBox(
    height: 400,
    child: Row(
      children: [
        Flexible(
          child: EditProject(
            onCancel: () => setState(() => _showProjectDetails = false),
            onSave: () {
              // Do nothing here if onSave expects no parameters
            },
            projectEntryVM: ProjectEntryVM(
              id: widget.project.id,
              title: widget.project.title,
              dateOfStart: widget.project.dateOfStart,
              dateOfTermination: widget.project.dateOfTermination,
              projectStatusId: widget.project.projectStatusId,
              customerId: widget.project.customerId,
              description: widget.project.description,
            ),
          ),
        ),
      ],
    ),
  );

  String getStatusString(int? statusId) {
    // Replace with your logic to fetch status based on statusId
    return 'Status'; // Placeholder
  }

  String getCustomerName(int? customerId) {
    // Replace with your logic to fetch customer name based on customerId
    return 'Kundenname'; // Placeholder
  }
}
