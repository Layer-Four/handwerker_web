import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/data_provider/customer_project/projekt_overview_provider.dart';
import '../shared_widgets/search_line_header.dart';
import '../shared_widgets/waiting_message_widget.dart';
import 'widgets/project_customer_overview_widget.dart';
import 'widgets/project_report_header.dart';

class ProjectReportOverviewView extends StatelessWidget {
  final ScrollController _scrollController;
  ProjectReportOverviewView({super.key}) : _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SearchLineHeader(title: 'Berichte'),
                const ProjectReportHeader(),
                SizedBox(
                  height: 11 * 60,
                  child: Consumer(
                    builder: (context, ref, child) => ref.watch(projektReportProvider).isEmpty
                        ? const WaitingMessageWidget('Lade Berichte')
                        : Scrollbar(
                            thumbVisibility: true,
                            controller: _scrollController,
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: ref.watch(projektReportProvider).length,
                              itemBuilder: (_, index) => ProjectCustomerOverviewWidget(
                                  ref.watch(projektReportProvider)[index]),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
