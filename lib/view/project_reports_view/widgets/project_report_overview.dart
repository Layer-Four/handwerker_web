import 'package:flutter/material.dart';
import '../../../models/project_models/project_report_dm/project_report_dm.dart';
import 'project_overview_head_widget.dart';
import 'singel_project_overview_widget.dart';

// ignore: must_be_immutable
class ProjectReportOverview extends StatelessWidget {
  final List<ProjectRepotsDM> projects;
  // final CustomeProject project;

  const ProjectReportOverview({super.key, required this.projects});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProjectReportOverviewHeadWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (_, i) => SingelProjectOverviewWidget(projects[i]),
              ),
            ),
          ),
        ],
      );
}