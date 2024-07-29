import 'package:flutter/material.dart';
import '../../../models/project_models/customer_projects_report_dm/customer_projects_report_dm.dart';
import '../../shared_widgets/error_message_widget.dart';
import 'project_report_overview.dart';

class ProjectCustomerOverviewWidget extends StatefulWidget {
  final CustomerProjectsReportDM customerProject;

  const ProjectCustomerOverviewWidget(this.customerProject, {super.key});

  @override
  State<ProjectCustomerOverviewWidget> createState() => _ProjectCustomerOverviewWidgetState();
}

class _ProjectCustomerOverviewWidgetState extends State<ProjectCustomerOverviewWidget> {
  late final CustomerProjectsReportDM _customProject;
  bool _isOpen = false;
  @override
  void initState() {
    super.initState();
    _customProject = widget.customerProject;
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4.0),
        child: Material(
          borderRadius: BorderRadius.circular(6),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => _isOpen = !_isOpen);
                  if (_customProject.projectsList.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => const ErrorMessageWidget(
                        'Keine Projekte oder Berichte vorhanden für diesen Kunden',
                      ),
                    );
                    setState(() => _isOpen = !_isOpen);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 6),
                  height: 69,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.58,
                        child: Tooltip(
                          message:
                              'Kundennummer: ${_customProject.customerCredentials.customerNumber}\nKontaktname: ${_customProject.customerCredentials.contactName}\nTelefonnummer: ${_customProject.customerCredentials.customerPhone}\nE-Mail: ${_customProject.customerCredentials.customerEmail}\nAdresse: ${_customProject.customerCredentials.customerStreet} ${_customProject.customerCredentials.customerStreetNr}, ${_customProject.customerCredentials.customerZipcode} ${_customProject.customerCredentials.customerCity}'
                              '',
                          textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                          child: Text(
                            _customProject.customerName,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.titleMedium,
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
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width * 0.05,
                          child: Icon(_isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),
              _isOpen
                  ? _customProject.projectsList.isNotEmpty
                      ? ProjectReportOverview(projects: _customProject.projectsList)
                      : const SizedBox.shrink()
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      );
}
