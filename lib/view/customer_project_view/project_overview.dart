import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'custom_project.dart';
import 'project_card.dart';

// ignore: must_be_immutable
class ProjectOverview extends StatefulWidget {
  const ProjectOverview({super.key});

  @override
  State<ProjectOverview> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<ProjectOverview> {
  final List<CustomeProject> project = [
    const CustomeProject(
      'Layer Four GmbH',
      'Austausch der\nHeizungsanlage',
      false,
      60000,
      11,
      '01.01.2024 - 01.06.2025',
      1009,
      1009,
    ),
    const CustomeProject(
      'Berlin AG',
      'Tisch gebaut',
      true,
      20000,
      11,
      '01.01.2024 - 01.06.2025',
      2099,
      9000,
    ),
    const CustomeProject(
      'Creative GmbH',
      'Fenster eingesetzt',
      true,
      20000,
      11,
      '01.01.2024 - 01.06.2025',
      2,
      900000,
    ),
    const CustomeProject(
      'Fio Bestmann',
      'Steinloch 43\n22880, Hamburg',
      true,
      20000,
      2,
      '01.01.2024 - 01.06.2025',
      2,
      1009,
    ),
    const CustomeProject(
      'Florian hensel',
      'große Straße 54\n22449, Kassel',
      true,
      20.000,
      2,
      '01.01.2024 - 01.06.2025',
      2,
      122000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenWidthInPercent = (MediaQuery.of(context).size.width / 100);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: screenWidthInPercent * 2),
            // ignore: sized_box_for_whitespace
            Container(
              width: screenWidthInPercent * 70,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Projekt',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Status',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        //    textAlign: TextAlign.right,
                      ),
                    ),
                    //     const Spacer(),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Zeitraum',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    //        const Spacer(),
                    Expanded(
                      flex: 2,
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: const Text(
                          '',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      ), //Placeholder so the spacers space accordingly.
                    ),
                  ],
                ),
              ),
            ),
            //   const Spacer(),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: screenWidth > 600 ? double.infinity : null,
          height: 300,
          child: ListView.builder(
            itemCount: project.length,
            itemBuilder: (_, index) => ProjectCard(
              project[index],
              isFirst: index == 0,
              isLast: index == project.length,
            ),
          ),
        ),
      ],
    );
  }
}
