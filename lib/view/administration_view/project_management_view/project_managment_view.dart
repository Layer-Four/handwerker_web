import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../../../provider/data_provider/project_provders/project_vm_provider.dart';
import '../../shared_widgets/add_button_widget.dart';
import '../../shared_widgets/search_line_header.dart';
import '../../shared_widgets/waiting_message_widget.dart';
import 'widgets/create_project_widget.dart';
import 'widgets/project_data_widget.dart';
import 'widgets/project_headline_widget.dart';

final Logger log = Logger('ProjectManagementBody');

class ProjectManagementBody extends ConsumerStatefulWidget {
  const ProjectManagementBody({super.key});

  @override
  ConsumerState<ProjectManagementBody> createState() => _ProjectManagementBodyState();
}

class _ProjectManagementBodyState extends ConsumerState<ProjectManagementBody> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchLineHeader(title: 'Projektverwaltung'),
                    const ProjectRowHeadline(),
                    ref.watch(projectVMProvider).projects.isEmpty
                        ? const WaitingMessageWidget('Lade Projektdaten')
                        : SizedBox(
                            height: 11 * 60,
                            child: ListView.builder(
                              itemCount: ref.watch(projectVMProvider).projects.length,
                              itemBuilder: (_, i) => ProjectDataCard(
                                key: ValueKey(ref.watch(projectVMProvider).projects[i].id),
                                project: ref.watch(projectVMProvider).projects[i],
                              ),
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
              onTap: () => setState(() => _isOpen = !_isOpen),
              hideAbleChild: _isOpen
                  ? CreateProjectWidget(onCancel: () => setState(() => _isOpen = !_isOpen))
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      );
}
