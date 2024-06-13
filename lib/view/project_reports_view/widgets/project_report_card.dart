import 'package:flutter/material.dart';

import '../../../models/project_models/project_report_dm/project_report_dm.dart';
import 'project_report_overview.dart';

// ignore: must_be_immutable
class ProjectReviewCard extends StatefulWidget {
  final List<ProjectRepotsDM> report;

  const ProjectReviewCard(this.report, {super.key});

  @override
  State<ProjectReviewCard> createState() => _ProjectReviewCardState();
}

class _ProjectReviewCardState extends State<ProjectReviewCard> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) => Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => isOpen = !isOpen),
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 8),
                              child: Text(
                                'widget.report.projectName',
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            const Tooltip(
                              message:
                                  'Kundennummer: 12345\nKontaktname: Max Mustermann\nTelefonnummer: +49 123 456789\nE-Mail: max@example.com\nAdresse: Musterstraße 1, 12345 Musterstadt',
                              textStyle: TextStyle(fontSize: 20, color: Colors.white),
                              child: Icon(
                                Icons.info_outline,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.23,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text('Umsatz in Euro',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700)),
                            ),
                          ),
                          Icon(isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          isOpen ? ProjectOverview(report: widget.report.first) : const SizedBox.shrink(),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
          )
        ],
      );
}
