import 'package:flutter/material.dart';

import 'custom_project.dart';
import 'project_overview.dart';

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
                  // Flexible(
                  //   flex: 22,
                  //   child:
                  //       // Column(
                  //       //   children: [
                  //       //     const Center(child: Text("2")),
                  //       //     const SizedBox(
                  //       //       height: 22,
                  //       //     ),
                  //       //     Container(
                  //       //       height: 100,
                  //       //       width: 200,
                  //       //       decoration: BoxDecoration(border: Border.all()),
                  //       //       child: const Column(
                  //       //         mainAxisAlignment: MainAxisAlignment.center,
                  //       //         crossAxisAlignment: CrossAxisAlignment.start,
                  //       //         children: [
                  //       //           Text("1 Begründung Herkules"),
                  //       //           Text("2 Begründung Schlosswiese"),
                  //       //         ],
                  //       //       ),
                  //       //     ),
                  //       //   ],
                  //       // ),

                  //       Table(
                  //     border: const TableBorder(
                  //       bottom:
                  //           BorderSide(), // Ensure bottom border for the table
                  //       right:
                  //           BorderSide(), // Ensure bottom border for the table
                  //     ),
                  //     defaultVerticalAlignment:
                  //         TableCellVerticalAlignment.middle,
                  //     columnWidths: const {
                  //       0: FlexColumnWidth(
                  //           2), // Setting the width of the first column to be 2 times the width of other columns
                  //     },
                  //     children: [
                  //       TableRow(
                  //         decoration: const BoxDecoration(
                  //           border: Border(
                  //             bottom: BorderSide(),
                  //             // top: BorderSide()
                  //           ), // Border for the header row
                  //         ),
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: const BoxDecoration(
                  //                 border: Border(
                  //                   right:
                  //                       BorderSide(), // Only add right border for Header 1
                  //                   // top: BorderSide
                  //                   //     .none, // Remove top border for Header 1
                  //                   // left: BorderSide
                  //                   //     .none, // Remove left border for Header 1
                  //                 ),
                  //               ),
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: const Text('2'),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: const BoxDecoration(
                  //                 border: Border(
                  //                   top:
                  //                       BorderSide(), // Only add right border for Header 1
                  //                 ),
                  //               ),
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: const Text('1 h'),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: const BoxDecoration(
                  //                 border: Border(
                  //                   top:
                  //                       BorderSide(), // Only add right border for Header 1
                  //                 ),
                  //               ),
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: const Text('1.099 EUR'),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: const BoxDecoration(
                  //                 border: Border(
                  //                   top:
                  //                       BorderSide(), // Only add right border for Header 1
                  //                 ),
                  //               ),
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: const Text('100.00 EUR'),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         decoration: const BoxDecoration(
                  //             border: Border(left: BorderSide())),
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: const BoxDecoration(
                  //                 border: Border(
                  //                     right:
                  //                         BorderSide()), // Add right border for this cell
                  //               ),
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: const Text('1 Begrünung Herkules'),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: const Text('5 h'),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: const Text('1000 EUR'),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: const Text('10.000 EUR'),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         decoration: const BoxDecoration(
                  //             border: Border(left: BorderSide())),
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: const BoxDecoration(
                  //                 border: Border(
                  //                     right:
                  //                         BorderSide()), // Add right border for this cell
                  //               ),
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: const Text('2 Begrünung Herkules'),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: const Text('6 h'),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: const Text('99 EUR'),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: const Text('990.000 EUR'),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
