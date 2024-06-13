import 'package:flutter/material.dart';

class ProjectReportHeader extends StatelessWidget {
  const ProjectReportHeader({super.key});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Row(
          children: [
            SizedBox(
              width:
                  // MediaQuery.of(context).size.width > 1000
                  //     ? 700                  :
                  MediaQuery.of(context).size.width * 0.55,
              child: Text(
                'Kunde',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Text(
              'Umsatz',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      );
}
