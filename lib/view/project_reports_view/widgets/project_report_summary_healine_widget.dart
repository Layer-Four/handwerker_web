import 'package:flutter/material.dart';

class ProjectSummaryHeadLineWidget extends StatelessWidget {
  const ProjectSummaryHeadLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Leistung/Material',
              //    textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          //  const Spacer(),
          Expanded(
              flex: 2,
              child: Text(
                'Menge',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          //   const Spacer(),
          Expanded(
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
            child: Text(
              '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
}
