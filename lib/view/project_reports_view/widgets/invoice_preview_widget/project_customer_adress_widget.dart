import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/customer_models/customer_credential/customer_credential.dart';

class ProjectCustomerAdressWidget extends StatelessWidget {
  final CustomerCredentialDM customer;
  const ProjectCustomerAdressWidget({
    super.key,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.89,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 160,
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 21.0),
                    child: Text(
                      'KundenInfo',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    customer.companyName,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    customer.contactName,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    '${customer.customerStreet ?? 'Keine Adresse'}  ${customer.customerStreetNr ?? '0'}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    '${customer.customerZipcode ?? 'Keine Adresse'} ${customer.customerCity ?? 'Keine Adresse'} ${(customer.country != null && customer.country != 'Deutschland') ? customer.country ?? 'Keine Adresse' : ''}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 150,
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 21.0),
                    child: Text(
                      'ProjektInfo',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    'Datum ${DateFormat('d.M.y').format(DateTime.now())} ',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    'ProjeketNummer: ${Random().nextInt(1000000000) + 89999999999}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
