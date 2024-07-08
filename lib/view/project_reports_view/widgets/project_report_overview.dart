import 'package:flutter/material.dart';
import '../../../models/project_models/project_report_dm/project_report_dm.dart';
import 'project_overview_head_widget.dart';
import 'singel_project_overview_widget.dart';

class ProjectReportOverview extends StatelessWidget {
  final List<ProjectRepotsDM> projects;

  const ProjectReportOverview({super.key, required this.projects});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 5),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProjectReportOverviewHeadWidget(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (_, i) => SingelProjectOverviewWidget(projects[i]),
                ),
              ),
            ),
          ],
        ),
      );
}
