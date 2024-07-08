import 'package:flutter/material.dart';

class ProjectReportHeader extends StatelessWidget {
  const ProjectReportHeader({super.key});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 8, top: 40, bottom: 24),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.58,
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
