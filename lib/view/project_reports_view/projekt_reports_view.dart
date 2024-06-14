import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/utilitis/utilitis.dart';
import '../../provider/data_provider/customer_project/projekt_overview_provider.dart';
import '../shared_widgets/search_line_header.dart';
import 'widgets/project_customer_overview_wiedget.dart';
import 'widgets/project_report_header.dart';

class ProjectOverviewView extends StatelessWidget {
  const ProjectOverviewView({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            const SearchLineHeader(title: 'Berichte'),
            const ProjectReportHeader(),
            SizedBox(
              height: 9 * 60,
              child: Consumer(
                builder: (context, ref, child) => ref.watch(projektReportProvider).isEmpty
                    ? Utilitis.waitingMessage(context, 'Lade Berichte')
                    : ListView.builder(
                        itemCount: ref.watch(projektReportProvider).length,
                        itemBuilder: (_, index) =>
                            ProjectCustomerOverviewWidget(ref.watch(projektReportProvider)[index]),
                      ),
              ),
            ),
          ],
        ),
      );
}