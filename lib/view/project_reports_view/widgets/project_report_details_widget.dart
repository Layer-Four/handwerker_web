import 'package:flutter/material.dart';
import '../../../constants/utilitis/utilitis.dart';
import '../../../models/project_models/project_report_dm/project_report_dm.dart';
import 'project_report_summary_widget.dart';

// ignore: must_be_immutable
class ProjectReportDetaisWidget extends StatefulWidget {
  final ProjectRepotsDM report;

  const ProjectReportDetaisWidget(this.report, {super.key});

  @override
  State<ProjectReportDetaisWidget> createState() => _ProjectReportDetaisWidgetState();
}

class _ProjectReportDetaisWidgetState extends State<ProjectReportDetaisWidget> {
  late final ProjectRepotsDM _report;
  bool isContainerOpen = false;
  @override
  void initState() {
    _report = widget.report;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Container(
                width: MediaQuery.of(context).size.width * 0.70,
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide()),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () => setState(() => isContainerOpen = !isContainerOpen),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Text(_report.projectName),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(_report.projectState?.value ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Utilitis.getStatusColor(_report.projectState?.value),
                                  )),
                        ),

                        Expanded(
                          flex: 8,
                          child: Text(_buildValidTimeString(), overflow: TextOverflow.ellipsis),
                        ),
                        //  const Spacer(),
                        Expanded(
                          flex: 8,
                          child: Text(
                            '${_report.projectRevenue?.toStringAsFixed(2) ?? 0} €',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
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
          isContainerOpen ? ProjectReportSummary(_report) : const SizedBox.shrink(),
        ],
      );

  String _buildValidTimeString() {
    final start = _report.dateOfStart ?? DateTime(2000);
    final end = _report.dateOfTermination ?? DateTime.now();

    return '${start.day}.${start.month}.${start.year} - ${end.day}.${end.month}.${end.year}';
  }
}
