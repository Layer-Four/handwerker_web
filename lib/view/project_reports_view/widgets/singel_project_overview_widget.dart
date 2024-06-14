import 'package:flutter/material.dart';
import '../../../constants/utilitis/utilitis.dart';
import '../../../models/project_models/project_report_dm/project_report_dm.dart';
import 'project_report_summary_widget.dart';

// ignore: must_be_immutable
class SingelProjectOverviewWidget extends StatefulWidget {
  final ProjectRepotsDM report;

  const SingelProjectOverviewWidget(this.report, {super.key});

  @override
  State<SingelProjectOverviewWidget> createState() => _SingelProjectOverviewWidgetState();
}

class _SingelProjectOverviewWidgetState extends State<SingelProjectOverviewWidget> {
  late final ProjectRepotsDM _project;
  bool isContainerOpen = false;
  @override
  void initState() {
    _project = widget.report;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide()),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () => setState(() => isContainerOpen = !isContainerOpen),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Text(_project.projectName),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text(_project.projectState?.value ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color:
                                            Utilitis.getStatusColor(_project.projectState?.value),
                                      )),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Text(
                                _buildValidTimeString(),
                              ),
                            ),
                            Text(
                              '${_project.projectRevenue?.toStringAsFixed(2) ?? 0} €',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                          child:
                              Icon(isContainerOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          isContainerOpen ? ProjectReportSummary(_project) : const SizedBox.shrink(),
        ],
      );

  String _buildValidTimeString() {
    final start = _project.dateOfStart ?? DateTime(2000);
    final end = _project.dateOfTermination ?? DateTime.now();

    return '${start.day}.${start.month}.${start.year} - ${end.day}.${end.month}.${end.year}';
  }
}
