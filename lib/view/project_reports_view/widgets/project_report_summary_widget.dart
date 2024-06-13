import 'package:flutter/material.dart';

import '../../../models/project_models/project_report_dm/project_report_dm.dart';
import 'project_description_widget.dart';
import 'project_report_summary_healine_widget.dart';
import 'project_report_utilitis_view.dart';

class ProjectReportSummary extends StatelessWidget {
  final ProjectRepotsDM project;
  const ProjectReportSummary(this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    final utilitis = [...project.serviceList, ...project.consumables];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          DescriptionFiedlWidget(project.projectDescription),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.60,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const ProjectSummaryHeadLineWidget(),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: utilitis.length,
                      itemBuilder: (ctx, i) => ProjectUtilitisView(utilitis[i]),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                            child: Text('editME!!!'),
                            // child: ProjectReportScreen(project: project),
                          ),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.folder_open),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Projektberichte (3)',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.orange,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


                    // const SizedBox(height: 20),
                    // exampleRow(const Icon(Icons.person), 'meister', '2 std.', '200,-€', '400,-€'),
                    // const SizedBox(height: 10),
                    // exampleRow(const Icon(Icons.person), 'meister', '2 stk.', '200,-€', '400,-€'),
                    // const SizedBox(height: 10),
                    // exampleRow(
                    //     const Icon(Icons.construction), 'Dachlatte', '2 stk.', '200,-€', '600,-€'),
                    // const SizedBox(height: 10),
                    // exampleRow(
                    //     const Icon(Icons.construction), 'Dachlatte', '2 stk.', '200,-€', '600,-€'),
                    // const SizedBox(height: 10),
                    // exampleRow(
                    //     const Icon(Icons.construction), 'Dachlatte', '2 stk.', '200,-€', '600,-€'),
                    // const SizedBox(height: 10),