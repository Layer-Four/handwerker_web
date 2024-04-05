import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:handwerker_web/view/customer_project_view/custom_project.dart';
import 'package:handwerker_web/view/customer_project_view/project_overview.dart';
import 'package:handwerker_web/view/customer_project_view/project_report.dart';

// ignore: must_be_immutable
class ProjectDetails extends StatefulWidget {
  final CustomeProject project;

  ProjectDetails(
    this.project, {
    super.key,
  });

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  Widget build(BuildContext context) {
    final screenWidthInPercent = (MediaQuery.of(context).size.width / 100);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: screenWidthInPercent * 2),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    'Beschreibung',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.fromLTRB(5, 5, 5, 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: const Text(
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
                      //   overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: screenWidthInPercent * 2),
          Container(
            // width: double.infinity,
            width: screenWidthInPercent * 60,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'Leistung/Material',
                          //    textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      //  const Spacer(),
                      const Expanded(
                          flex: 2,
                          child: Text(
                            'Menge',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                      //   const Spacer(),
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'Preis',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      //  const Spacer(),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: const Text(
                            '',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  exampleRow(const Icon(Icons.person), 'meister', '2 std.', '200,-€', '400,-€'),
                  const SizedBox(height: 10),
                  exampleRow(const Icon(Icons.person), 'meister', '2 stk.', '200,-€', '400,-€'),
                  const SizedBox(height: 10),
                  exampleRow(const Icon(Icons.construction), 'Dachlatte', '2 stk.', '200,-€', '600,-€'),
                  const SizedBox(height: 10),
                  exampleRow(const Icon(Icons.construction), 'Dachlatte', '2 stk.', '200,-€', '600,-€'),
                  const SizedBox(height: 10),
                  exampleRow(const Icon(Icons.construction), 'Dachlatte', '2 stk.', '200,-€', '600,-€'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        print('clicked');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: ProjectReportScreen(project: widget.project),
                            );
                          },
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

Widget exampleRow(Icon icon, String leistung, String menge, String preis, String umsatz) => Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              icon,
              const SizedBox(
                width: 2,
              ),
              Text(
                leistung,
                //    textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        //  const Spacer(),
        Expanded(
            flex: 2,
            child: Text(
              menge,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            )),
        //   const Spacer(),
        Expanded(
          flex: 2,
          child: Text(
            preis,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        //  const Spacer(),
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              umsatz,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
