import 'package:flutter/material.dart';

import '../../models/project_models/customer_projekt_model/custom_project.dart';
import 'project_overview.dart';

// ignore: must_be_immutable
class CharacterCard extends StatefulWidget {
  final CustomeProject project;
  final bool isFirst;
  final bool isLast;
  bool isContainerOpen;

  CharacterCard(
    this.project, {
    super.key,
    this.isFirst = false,
    this.isLast = false,
    this.isContainerOpen = false,
  });

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
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
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.isContainerOpen = !widget.isContainerOpen;
                });
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: screenWidthInPercent * 80, //If we remove this, it crashes. Sloppy fix
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
                          const Tooltip(
                            message:
                                'Kundennummer: 12345\nKontaktname: Max Mustermann\nTelefonnummer: +49 123 456789\nE-Mail: max@example.com\nAdresse: Musterstraße 1, 12345 Musterstadt',
                            textStyle: TextStyle(fontSize: 20, color: Colors.white),
                            child: Icon(
                              Icons.info_outline,
                              size: 20,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${widget.project.revenue},- €',
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          Icon(
                              widget.isContainerOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                          const SizedBox(
                            //pushes icon into visible range, otherwise icon is invisible
                            width: 130,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
                visible: widget.isContainerOpen,
                child: ProjectOverview(
                  project: widget.project,
                )),
            if (false) //widget.isContainerOpen
              // ignore: dead_code
              const Row(
                children: [
                  Flexible(
                    flex: 5, // 20%
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Berlin AG',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Kundennummer:134D8282',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text('Kontakt'),
                        Text(
                          'Ansprechpartner:Jürgen Holz\nTelefon:016037372\nE-Mail:kunden@handwerker.de',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text('Adresse:'),
                        Text(
                          'Berliner Straße 234\n2290 Berlin',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    flex: 18,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Proeject 1'),
                            Text('20.000 \$'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Proeject 2'),
                            Text('20.000 \$'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Proeject 2'),
                            Text('20.000 \$'),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
