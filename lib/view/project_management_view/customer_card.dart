import 'package:flutter/material.dart';

import '../customer_project_view/custom_project.dart';

// ignore: must_be_immutable
class CustomerCard extends StatefulWidget {
  final CustomeProject project;
  final bool isFirst;
  final bool isLast;
  bool isContainerOpen;

  CustomerCard(
    this.project, {
    super.key,
    this.isFirst = false,
    this.isLast = false,
    this.isContainerOpen = false,
  });

  @override
  State<CustomerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidthInPercent = (MediaQuery.of(context).size.width / 100);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: widget.isFirst ? BorderSide.none : const BorderSide(),
          // left: const BorderSide(),
          // right: const BorderSide(),
          bottom: widget.isLast ? const BorderSide() : BorderSide.none,
        ),
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
                    width: screenWidthInPercent *
                        80, //If we remove this, it crashes. Sloppy fix
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.project.customer,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Tooltip(
                          message:
                              'Kunde: ${widget.project.customer}\nKontaktname: Max Mustermann\nTelefonnummer: +49 123 456789\nE-Mail: max@example.com\nAdresse: Musterstraße 1, 12345 Musterstadt',
                          textStyle: const TextStyle(
                              fontSize: 20, color: Colors.white),
                          child: const Icon(
                            Icons.info_outline,
                            size: 20,
                          ),
                        ),
                        const Spacer(),
                        // Icon(widget.isContainerOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                        const Icon(Icons.edit_document),
                        const SizedBox(
                          //pushes icon into visible range, otherwise icon is invisible
                          width: 190,
                        ),
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
}
