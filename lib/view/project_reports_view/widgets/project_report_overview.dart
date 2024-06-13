import 'package:flutter/material.dart';
import '../../../models/project_models/project_report_dm/project_report_dm.dart';
import 'project_overview_head_widget.dart';
import 'project_report_details_widget.dart';

// ignore: must_be_immutable
class ProjectReportOverview extends StatelessWidget {
  final List<ProjectRepotsDM> projects;
  // final CustomeProject project;

  const ProjectReportOverview({super.key, required this.projects});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const ProjectReportOverviewHeadWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (_, i) => ProjectReportDetaisWidget(projects[i]),
              ),
            ),
          ),
        ],
      );
}
