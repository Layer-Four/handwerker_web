import 'package:flutter/material.dart';
import '../../../constants/utilitis/utilitis.dart';
import '../../../models/project_models/project_report_dm/project_report_dm.dart';
import 'project_report_summary_widget.dart';

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
          GestureDetector(
            onTap: () => setState(() => isContainerOpen = !isContainerOpen),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.24,
                    child: Text(
                      _project.projectName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.18,
                    child: Text(_project.projectState?.value ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Utilitis.getStatusColor(_project.projectState?.value),
                            )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.17,
                    child: Text(
                      _buildValidTimeString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 1000
                        ? MediaQuery.of(context).size.width * 0.10
                        : MediaQuery.of(context).size.width * 0.2,
                    child: Text(
                      '${_project.projectRevenue?.toStringAsFixed(2) ?? 0} €',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width * 0.045,
                      child: Icon(isContainerOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down))
                ],
              ),
            ),
          ),
          isContainerOpen ? ProjectReportSummary(_project) : const SizedBox.shrink(),
          Divider(
            height: 10,
            // color: Colors.black,
            thickness: 1.0,
            endIndent: MediaQuery.of(context).size.width * 0.1,
          )
        ],
      );

  String _buildValidTimeString() {
    final start = _project.dateOfStart ?? DateTime(2000);
    final end = _project.dateOfTermination ?? DateTime.now();

    return '${start.day}.${start.month}.${start.year} - ${end.day}.${end.month}.${end.year}';
  }
}
