import 'package:flutter/material.dart';

class ProjectSummaryHeadLineWidget extends StatelessWidget {
  const ProjectSummaryHeadLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.18,
            child: Text(
              'Leistung/Material',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.17,
              child: Text(
                'Menge',
                overflow: TextOverflow.ellipsis,
                style:
                    Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width > 1000
                ? MediaQuery.of(context).size.width * 0.10
                : MediaQuery.of(context).size.width * 0.2,
            child: Text(
              'Preis',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
}
