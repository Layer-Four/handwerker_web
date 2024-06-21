import 'package:flutter/material.dart';

class ProjectReportOverviewHeadWidget extends StatelessWidget {
  const ProjectReportOverviewHeadWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      // SizedBox(
      // width: MediaQuery.of(context).size.width * 0.8,
      // child:
      Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.24,
            child: Text(
              'Projekt',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              // style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.18,
            child: Text(
              'Status',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.17,
            child: Text(
              'Zeitraum',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        // ),
      );
}
