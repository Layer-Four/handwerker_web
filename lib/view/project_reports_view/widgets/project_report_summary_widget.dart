import 'package:flutter/material.dart';

import '../../../constants/themes/app_color.dart';
import '../../../models/project_models/project_report_dm/project_report_dm.dart';
import 'project_description_widget.dart';
import 'project_report_summary_healine_widget.dart';
import 'project_report_utilitis_view.dart';
import 'project_reports_reports_widget.dart';

class ProjectReportSummary extends StatelessWidget {
  final ProjectRepotsDM project;
  const ProjectReportSummary(this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    final utilitis = [...project.serviceList, ...project.consumables];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.24,
            child: project.projectDescription != null
                ? DescriptionFiedlWidget(project.projectDescription)
                : const SizedBox(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProjectSummaryHeadLineWidget(),
                Container(
                  alignment: Alignment.centerLeft,
                  height: project.projectDescription != null
                      ? 100
                      : utilitis.length > 4
                          ? 100
                          : utilitis.length * 40,
                  child: ListView.builder(
                    itemCount: utilitis.length,
                    itemBuilder: (ctx, i) => ProjectUtilitisView(utilitis[i]),
                  ),
                ),
                project.reportsList.isEmpty
                    ? const SizedBox.shrink()
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(border: Border.all()),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              barrierColor: const Color.fromARGB(20, 0, 0, 0),
                              context: context,
                              builder: (context) => Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width * 0.10,
                                  vertical: MediaQuery.of(context).size.height * 0.10,
                                ),
                                child: Material(
                                  clipBehavior: Clip.antiAlias,
                                  borderRadius: BorderRadius.circular(20),
                                  child: ProjectReportsShowWidget(project.reportsList),
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.folder_open),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text('Projektberichte (${project.reportsList.length})',
                                    style: TextStyle(
                                      color: AppColor.kPrimaryButtonColor,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
