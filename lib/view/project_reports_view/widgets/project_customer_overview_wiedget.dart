import 'package:flutter/material.dart';

import '../../../models/project_models/customer_projects_report_dm/customer_projects_report_dm.dart';
import 'project_report_overview.dart';

// ignore: must_be_immutable
class ProjectCustomerOverviewWidget extends StatefulWidget {
  final CustomerProjectsReportDM customerProject;

  const ProjectCustomerOverviewWidget(this.customerProject, {super.key});

  @override
  State<ProjectCustomerOverviewWidget> createState() => _ProjectCustomerOverviewWidgetState();
}

class _ProjectCustomerOverviewWidgetState extends State<ProjectCustomerOverviewWidget> {
  late final CustomerProjectsReportDM _customProject;
  bool isOpen = false;
  @override
  void initState() {
    super.initState();
    _customProject = widget.customerProject;
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                            Tooltip(
                              message:
                                  'Kundennummer: ${_customProject.customerCredentials.customerNumber}\nKontaktname: ${_customProject.customerCredentials.contactPerson}\nTelefonnummer: ${_customProject.customerCredentials.customerPhone}\nE-Mail: ${_customProject.customerCredentials.customerEmail}\nAdresse: ${_customProject.customerCredentials.customerStreet} ${_customProject.customerCredentials.customerStreetNr}, ${_customProject.customerCredentials.customerZipcode} ${_customProject.customerCredentials.customerCity}'
                                  '',
                              textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0, right: 8),
                                child: Text(
                                  _customProject.customerName,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
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
                              child: Text(
                                  '${_customProject.customerRevenue?.toStringAsFixed(2) ?? '0,0'}€',
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
          isOpen
              ? ProjectReportOverview(projects: _customProject.projectsList)
              : const SizedBox.shrink(),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
          )
        ],
      );
}