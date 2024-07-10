import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../../../constants/utilitis/utilitis.dart';
import '../../../models/project_models/project_entry_vm/project_entry_vm.dart';
import '../../../provider/data_provider/project_provders/project_vm_provider.dart';
import '../../shared_widgets/add_button_widget.dart';
import '../../shared_widgets/search_line_header.dart';
import 'widgets/edit_project.dart';
import 'package:handwerker_web/view/administration_view/project_management_view/widgets/projectcard.dart';

import 'widgets/project_headline_widget.dart';

final Logger log = Logger('ProjectManagementBody');

class ProjectManagementBody extends ConsumerStatefulWidget {
  const ProjectManagementBody({super.key});

  @override
  ConsumerState<ProjectManagementBody> createState() => _ProjectManagementBodyState();
}

class _ProjectManagementBodyState extends ConsumerState<ProjectManagementBody> {
  bool _isOpen = false;
  ProjectEntryVM? _currentProject;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(projectVMProvider);

    if (notifier.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchLineHeader(title: 'Projektverwaltung'),
                  const ProjectRowHeadline(),
                  notifier.projects.isEmpty
                      ? const Text('Keine Projekte verfügbar')
                      : SizedBox(
                          height: 11 * 60,
                          child: ListView.builder(
                            itemCount: notifier.projects.length,
                            itemBuilder: (_, index) {
                              final project = notifier.projects[index];
                              return ProjectCard(
                                key: ValueKey(index),
                                project: project,
                                onDelete: () {
                                  setState(() {
                                    notifier.projects.removeAt(index);
                                  });
                                },
                                onUpdate: (updatedProject) {
                                  setState(() {
                                    notifier.projects[index] = updatedProject;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 10,
          child: AddButton(
            isOpen: _isOpen,
            onTap: () {
              setState(() {
                _isOpen = !_isOpen;
                _currentProject = null; // Reset current project for add
              });
            },
            hideAbleChild: _isOpen
                ? Container(
                    width: MediaQuery.of(context).size.width > 900
                        ? 900
                        : MediaQuery.of(context).size.width,
                    child: EditProject(
                      onSave: () {
                        setState(() => _isOpen = false);
                      },
                      onCancel: () {
                        setState(() => _isOpen = false);
                      },
                      projectEntryVM: _currentProject ?? const ProjectEntryVM(),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
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
