import 'package:flutter/material.dart';
import '../../../models/project_models/customer_projects_report_dm/customer_projects_report_dm.dart';
import 'project_report_overview.dart';

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
            child: Material(
              // shadowColor: ,
              elevation: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  border: const Border(bottom: BorderSide()),
                ),
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.59,
                      child: Tooltip(
                        message:
                            'Kundennummer: ${_customProject.customerCredentials.customerNumber}\nKontaktname: ${_customProject.customerCredentials.contactName}\nTelefonnummer: ${_customProject.customerCredentials.customerPhone}\nE-Mail: ${_customProject.customerCredentials.customerEmail}\nAdresse: ${_customProject.customerCredentials.customerStreet} ${_customProject.customerCredentials.customerStreetNr}, ${_customProject.customerCredentials.customerZipcode} ${_customProject.customerCredentials.customerCity}'
                            '',
                        textStyle: const TextStyle(fontSize: 20, color: Colors.white),
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width > 1000
                          ? MediaQuery.of(context).size.width * 0.10
                          : MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        '${_customProject.customerRevenue?.toStringAsFixed(2) ?? '0,0'}€',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: Icon(isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down)),
                  ],
                ),
              ),
            ),
          ),
          isOpen
              ? ProjectReportOverview(projects: _customProject.projectsList)
              : const SizedBox.shrink(),
          // const Divider(
          //   height: 5,
          //   indent: 10,
          //   endIndent: 30,
          //   thickness: 1.5,
          //   color: Colors.black,
          // ),
        ],
      );
}
