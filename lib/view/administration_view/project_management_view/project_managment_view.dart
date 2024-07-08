import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../../../models/project_entry_models/project_entry_vm/project_entry_vm.dart';
import '../../../provider/data_provider/project_provders/project_vm_provider.dart';
import '../../shared_widgets/add_button_widget.dart';
import '../../shared_widgets/search_line_header.dart';
import 'widgets/edit_project.dart';

final Logger log = Logger('ProjectManagementBody');

class ProjectManagementBody extends ConsumerStatefulWidget {
  const ProjectManagementBody({super.key});

  @override
  ConsumerState<ProjectManagementBody> createState() => _ProjectManagementBodyState();
}

class _ProjectManagementBodyState extends ConsumerState<ProjectManagementBody> {
  bool _isOpen = false;
  // bool _isSnackbarShowed = false;
  ProjectEntryVM? _currentProject;

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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchLineHeader(title: 'Projektverwaltung'),
            notifier.projects.isEmpty
                ? const Text('Keine Projekte verfügbar')
                : SizedBox(
                    height: 9 * 74,
                    child: ListView.builder(
                      itemCount: notifier.projects.length,
                      itemBuilder: (_, index) {
                        final project = notifier.projects[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        project.title ?? 'Unbenanntes Projekt',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () => _openEditProjectDialog(project),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () => _deleteProject(ref, project.id ?? -1),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 16), // Adjust left margin for spacing
                              color: Colors.grey, // Color of the underline
                              height: 1, // Height of the underline
                              width: double.infinity, // Full width
                            ),
                          ],
                        );
                      },
                    ),
                  ),
            AddButton(
              onTap: () {
                setState(() {
                  _isOpen = !_isOpen;
                  _currentProject = null; // Reset current project for add
                });
              },
              isOpen: _isOpen,
              hideAbleChild: _isOpen
                  ? EditProject(
                      onSave: () {
                        Navigator.of(context).pop();
                      },
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                      projectEntryVM: _currentProject ?? const ProjectEntryVM(),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  void _openEditProjectDialog(ProjectEntryVM project) {
    setState(() {
      _isOpen = true;
      _currentProject = project;
    });
  }

  void _deleteProject(WidgetRef ref, int projectId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Projekt löschen'),
        content: const Text('Sind sie sicher, dass sie das Projekt löschen wollen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () {
              ref.read(projectVMProvider).deleteProject(projectId);
              Navigator.of(context).pop();
            },
            child: const Text(
              'Löschen',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // void _updateProject(
  //     BuildContext context, WidgetRef ref, int? projectId, ProjectEntryVM updatedProject) {
  //   ref
  //       .read(projectVMProvider)
  //       .updateProject(projectId, updatedProject); // Pass ID and updated project
  // }
}
