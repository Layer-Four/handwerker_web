import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/customer_models/customer_credential/customer_credential.dart';
import '../../../../models/project_models/project_report_dm/project_report_dm.dart';
import '../../../../models/time_models/project_time_model/project_time_entry.dart';
import '../../../../provider/data_provider/time_entry_provider/time_entry_provider.dart';
import 'invoice_consumable_widget.dart';
import 'invoice_docu_widget.dart';
import 'invoice_time_widget.dart';
import 'project_customer_adress_widget.dart';

class ProjectCustomerReviewPreviewWidget extends ConsumerWidget {
  final ProjectRepotsDM project;
  final CustomerCredentialDM customer;
  const ProjectCustomerReviewPreviewWidget(
      {super.key, required this.project, required this.customer});

  @override
  Widget build(BuildContext context, ref) => Dialog(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ProjectCustomerAdressWidget(customer: customer),
                const Divider(
                  height: 10,
                  thickness: 1,
                  // indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (ProjectTimeEntry e in project.reportsList) InvoiceDokuWidgets(docu: e),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  // indent: 20,
                  endIndent: 20,
                ),
                InvoiceConsumableWidget(
                  consumables: project.consumables,
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  // indent: 20,
                  endIndent: 20,
                ),
                InvoiceTimeWidget(
                  times: ref
                      .watch(timeVMProvider.notifier)
                      .entries
                      .where((e) => e.project?.id == project.projectState?.id)
                      .toList(),
                )
              ],
            ),
          ),
        ),
      );
}
