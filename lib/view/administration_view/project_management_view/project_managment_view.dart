import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../../../constants/utilitis/utilitis.dart';
import '../../../models/project_models/project_entry_vm/project_entry_vm.dart';
import '../../../provider/data_provider/project_provders/project_vm_provider.dart';
import '../../shared_widgets/add_button_widget.dart';
import '../../shared_widgets/search_line_header.dart';
import 'widgets/create_project_widget.dart';
import 'widgets/update_project_widget.dart';

final Logger log = Logger('ProjectManagementBody');

class ProjectManagementBody extends ConsumerStatefulWidget {
  const ProjectManagementBody({super.key});

  @override
  ConsumerState<ProjectManagementBody> createState() => _ProjectManagementBodyState();
}

class _ProjectManagementBodyState extends ConsumerState<ProjectManagementBody> {
  bool _isOpen = false;
  final ScrollController _scrollController = ScrollController();
  // bool _isSnackbarShowed = false;
  // ProjectEntryVM? _currentProject;

  // void _showSnackBar(String message) {
  //   if (_isSnackbarShowed) return;
  //   setState(() => _isSnackbarShowed = true);
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Center(child: Text(message)),
  //       duration: const Duration(seconds: 7),
  //     ),
  //   );
  //   Future.delayed(const Duration(seconds: 7)).then(
  //     (_) => setState(() => _isSnackbarShowed = false),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(projectVMProvider);

    if (notifier.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchLineHeader(title: 'Projektverwaltung'),
              notifier.isLoading
                  ? Utilitis.waitingMessage(context, 'Lade Kundendaten')
                  : SizedBox(
                      height: 11 * 60,
                      child: Scrollbar(
                        thumbVisibility: true,
                        controller: _scrollController,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: notifier.projects.length,
                          itemBuilder: (_, index) {
                            log.info(notifier.projectVms[index].toJson());
                            return ProjectDataWidget(project: notifier.projectVms[index]);
                          },
                        ),
                      ),
                    ),
              // _currentProject = null; // Reset current project for add
            ],
          ),
          Positioned(
            left: 10,
            bottom: 50,
            child: AddButton(
              onTap: () => setState(() => _isOpen = !_isOpen),
              isOpen: _isOpen,
              // Navigator.of(context).pop();
              // Navigator.of(context).pop();
              hideAbleChild: CreateProjectWidget(
                onSave: () => setState(() => _isOpen = !_isOpen),
                onCancel: () => setState(() => _isOpen = !_isOpen),
                // projectEntryVM: null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _deleteProject(int projectId) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Projekt löschen'),
  //       content: const Text('Sind sie sicher, dass sie das Projekt löschen wollen?'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: const Text('Abbrechen'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text(
  //             'Löschen',
  //             style: TextStyle(color: Colors.red),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _updateProject(
  //     BuildContext context, WidgetRef ref, int? projectId, ProjectEntryVM updatedProject) {
  //   ref
  //       .read(projectVMProvider)
  //       .updateProject(projectId, updatedProject); // Pass ID and updated project
  // }
}

class ProjectDataWidget extends ConsumerStatefulWidget {
  final ProjectEntryVM project;
  const ProjectDataWidget({super.key, required this.project});

  @override
  ConsumerState<ProjectDataWidget> createState() => _ProjectDataWidgetState();
}

class _ProjectDataWidgetState extends ConsumerState<ProjectDataWidget> {
  bool _isEdit = false;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4.0),
        child: Material(
          elevation: 3,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => setState(() => _isEdit = !_isEdit),
                child: SizedBox(
                  height: 69,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.project.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => setState(() => _isEdit = !_isEdit),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => Utilitis.askPopUp(context,
                                message: 'Möchten sie dieses Projekt wirklich löschen?',
                                onAccept: () => ref
                                        .read(projectVMProvider)
                                        .deleteProject(widget.project.id!)
                                        .then((e) {
                                      Navigator.of(context).pop();
                                      Utilitis.showSnackBar(
                                          context,
                                          e
                                              ? 'Projekt wurde gelöscht'
                                              : 'Leider lief etwas schief, Projekt konnte nicht gelöscht werden');
                                    }),
                                onReject: () => Navigator.of(context).pop()),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              _isEdit ? UpdateProjectWidget(widget.project) : const SizedBox.shrink()
            ],
          ),
        ),
      );
}
