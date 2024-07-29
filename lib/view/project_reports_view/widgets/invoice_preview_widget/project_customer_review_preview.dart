import 'package:flutter/material.dart';

import '../../../../models/customer_models/customer_credential/customer_credential.dart';
import '../../../../models/project_models/project_report_dm/project_report_dm.dart';
import 'invoice_body_widget.dart';
import 'project_customer_adress_widget.dart';

class ProjectCustomerReviewPreviewWidget extends StatelessWidget {
  final ProjectRepotsDM project;
  const ProjectCustomerReviewPreviewWidget({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) => Dialog(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const ProjectCustomerAdressWidget(
                  // TODO: get ref or give with dependeny injection
                  customer: CustomerCredentialDM(
                    contactName: 'Marten Meißner',
                    companyName: 'Layer Four GmbH',
                    customerCity: 'Kassel',
                    customerEmail: 'marten.meissner@layer-four.de',
                    customerNumber: 'KS0815116117',
                    customerPhone: '0815/116117',
                    customerStreet: 'Hildegard-von-Bingen-Straße',
                    customerStreetNr: '5',
                    customerZipcode: '34131',
                    country: 'Deutschlande',
                  ),
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                      itemCount: project.reportsList.length,
                      itemBuilder: (context, i) => InvoiceDokuWidgets(
                            key: ValueKey(i),
                            docu: project.reportsList[i],
                          )),
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            ),
          ),
        ),
      );
}
