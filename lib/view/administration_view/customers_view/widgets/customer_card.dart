import 'package:flutter/material.dart';

import '../../../../models/project_models/customer_projekt_model/custom_project.dart';

class CustomerCard extends StatefulWidget {
  final CustomeProject project;

  const CustomerCard(this.project, {super.key});

  @override
  State<CustomerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide()),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.project.customer,
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Tooltip(
                            message:
                                'Kunde: ${widget.project.customer}\nKontaktname: Max Mustermann\nTelefonnummer: +49 123 456789\nE-Mail: max@example.com\nAdresse: Musterstraße 1, 12345 Musterstadt',
                            textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                            child: const Icon(
                              Icons.info_outline,
                              size: 20,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.edit_document),
                          const SizedBox(width: 190),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
