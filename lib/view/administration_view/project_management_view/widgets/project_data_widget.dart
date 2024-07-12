import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/project_models/project_entry_vm/project_entry_vm.dart';
import '../../../../provider/data_provider/project_provders/project_vm_provider.dart';
import '../../../shared_widgets/ask_agreement_widget.dart';
import 'update_project_widget.dart';

class ProjectDataCard extends ConsumerStatefulWidget {
  final ProjectEntryVM project;

  const ProjectDataCard({super.key, required this.project});

  @override
  ConsumerState<ProjectDataCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectDataCard> {
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
                onTap: () {
                  if (_showProjectDetails) {
                    ref.read(projectVMProvider.notifier).clearEditableProject();
                  } else {
                    ref.read(projectVMProvider.notifier).updateEditableEntry(
                          newCustomer: widget.project.customer,
                          newDescription: widget.project.description,
                          newStart: widget.project.start,
                          newState: widget.project.state,
                          newTermination: widget.project.terminationDate,
                          newTitle: widget.project.title,
                          newID: widget.project.id,
                        );
                  }
                  setState(() {
                    _showProjectDetails = !_showProjectDetails;
                  });
                },
                child: Container(
                  height: 69,
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Tooltip(
                        message:
                            'Projekt: ${widget.project.title}\nStartdatum: ${DateFormat('d.M.y').format(widget.project.start)}\nEnddatum: ${DateFormat('d.M.y').format(widget.project.terminationDate)}\nStatus: ${widget.project.state.title}\nKunde: ${widget.project.customer!.companyName}\nBeschreibung: ${widget.project.description}',
                        textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                        child: Text(
                          widget.project.title,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => AskoForAgreement(
                                message: 'Sind Sie sicher, dass Sie dieses Projekt löschen wollen?',
                                onAccept: () => ref
                                    .read(projectVMProvider.notifier)
                                    .deleteProject(widget.project)
                                    .then((e) {
                                  Navigator.of(context).pop();
                                  Utilitis.showSnackBar(
                                      context,
                                      e
                                          ? 'Projekt wurde erfolgreich gelöscht'
                                          : 'Leider ist etwas schief gegangen\nProjekt kann nicht gelöscht werden');
                                }),
                                onReject: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () =>
                                setState(() => _showProjectDetails = !_showProjectDetails),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _showProjectDetails
                  ? UpdateProjectWidget(
                      widget.project,
                      onCancel: () {
                        ref.read(projectVMProvider.notifier).clearEditableProject();
                        setState(() => _showProjectDetails = !_showProjectDetails);
                      },
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      );
}
