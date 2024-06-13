import 'package:flutter/material.dart';

class ProjectReportOverviewHeadWidget extends StatelessWidget {
  const ProjectReportOverviewHeadWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  'Projekt',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  // style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(
                  'Status',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(
                  'Zeitraum',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              //        const Spacer(),
              const Expanded(
                flex: 8,
                child: Text(
                  '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ), //Placeholder so the spacers space accordingly.
              ),
              const Expanded(flex: 1, child: SizedBox.shrink())
            ],
          ),
        ),
      );
}
