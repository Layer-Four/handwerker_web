import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/customer_models/customer_credential/customer_credential.dart';
import '../../models/project_models/project_report_dm/project_report_dm.dart';
import '../../models/time_models/time_vm/time_vm.dart';
import 'widgets/invoice_preview_widget/invoice_consumable_widget.dart';
import 'widgets/invoice_preview_widget/invoice_docu_widget.dart';
import 'widgets/invoice_preview_widget/invoice_time_widget.dart';
import 'widgets/invoice_preview_widget/project_customer_adress_widget.dart';

class InvoicePreviewWidget extends ConsumerWidget {
  final List<TimeVMAdapter> times;
  final ProjectRepotsDM project;
  final CustomerCredentialDM customer;
  const InvoicePreviewWidget({
    super.key,
    required this.project,
    required this.customer,
    required this.times,
  });

  @override
  Widget build(BuildContext context, ref) => Dialog(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ProjectCustomerAdressWidget(customer: customer),
                const Divider(height: 10, thickness: 1, endIndent: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                    itemBuilder: (context, index) => InvoiceDokuWidgets(
                      docu: project.reportsList[index],
                    ),
                  ),
                ),
                const Divider(height: 8, thickness: 1, endIndent: 20),
                InvoiceConsumableWidget(
                  consumables: project.consumables,
                ),
                const Divider(
                  height: 8,
                  thickness: 1,
                  // indent: 20,
                  endIndent: 20,
                ),
                InvoiceTimeWidget(times: times)
              ],
            ),
          ),
        ),
      );
}
