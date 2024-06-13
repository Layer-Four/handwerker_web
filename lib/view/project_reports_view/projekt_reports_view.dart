import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/utilitis/utilitis.dart';
import '../../provider/data_provider/customer_project/projekt_overview_provider.dart';
import '../shared_widgets/search_line_header.dart';
import 'widgets/project_report_card.dart';

class ProjectOverviewView extends StatelessWidget {
  const ProjectOverviewView({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            const SearchLineHeader(title: 'Berichte'),
            _buldProjectTitleHeader(context),
            SizedBox(
              height: 9 * 74,
              child: Consumer(
                builder: (context, ref, child) => ref.watch(projektReportProvider).isEmpty
                    ? Utilitis.waitingMessage(context, 'Lade Berichte')
                    : ListView.builder(
                        itemCount: ref.watch(projektReportProvider).length,
                        itemBuilder: (_, index) =>
                            ProjectReviewCard(ref.watch(projektReportProvider)[index].projectsList),
                      ),
              ),
            ),
          ],
        ),
      );

  Padding _buldProjectTitleHeader(BuildContext context) => Padding(
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
