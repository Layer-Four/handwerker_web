import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/data_provider/customer_project/projekt_overview_provider.dart';
import '../shared_widgets/search_line_header.dart';
import '../shared_widgets/waiting_message_widget.dart';
import 'widgets/project_customer_overview_widget.dart';
import 'widgets/project_report_header.dart';

class ProjectReportOverviewView extends ConsumerStatefulWidget {
  const ProjectReportOverviewView({super.key});

  @override
  ConsumerState<ProjectReportOverviewView> createState() => _ProjectReportOverviewViewState();
}

class _ProjectReportOverviewViewState extends ConsumerState<ProjectReportOverviewView> {
  late final ScrollController _scrollController;
  bool _isProviderInit = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(_isProviderInit.toString());
    if (_isProviderInit == false) {
      if (ref.watch(projektReportProvider.notifier).isInit) _isProviderInit = true;
    }
    return SizedBox(
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
                child: _isProviderInit
                    ? ref.watch(projektReportProvider).isEmpty
                        ? const Center(child: Text('Keine Kunden und Projekte gefunden'))
                        : Scrollbar(
                            thumbVisibility: true,
                            controller: _scrollController,
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: ref.watch(projektReportProvider).length,
                              itemBuilder: (_, index) => ProjectCustomerOverviewWidget(
                                key: ValueKey(ref.watch(projektReportProvider)[index]),
                                ref.watch(projektReportProvider)[index],
                              ),
                            ),
                          )
                    : const WaitingMessageWidget('Lade Berichte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
