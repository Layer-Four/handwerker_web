import 'package:flutter/material.dart';

class ProjectSummaryHeadLineWidget extends StatelessWidget {
  const ProjectSummaryHeadLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: const Text(
              'Leistung/Material',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: const Text(
                'Menge',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: const Text(
              'Preis',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
}
