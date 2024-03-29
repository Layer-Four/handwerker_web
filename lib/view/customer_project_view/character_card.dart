import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:handwerker_web/view/customer_project_view/custom_project.dart';

// ignore: must_be_immutable
class CharacterCard extends StatefulWidget {
  final CustomeProject project;
  final bool isLast;
  bool isContainerOpen;
  CharacterCard(
    this.project, {
    super.key,
    this.isLast = false,
    this.isContainerOpen = false,
  });

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    final screenWihdthinProzents = (MediaQuery.of(context).size.width / 100);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(),
          // left: const BorderSide(),
          // right: const BorderSide(),
          bottom: widget.isLast ? const BorderSide() : BorderSide.none,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    // SizedBox(
                    //   width: screenWihdthinProzents * 20,
                    //   child: Text(
                    //     widget.project.description,
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: screenWihdthinProzents * 11,
                    //   child: Text(
                    //     '${widget.project.projectNumber}',
                    //     textAlign: TextAlign.right,
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: screenWihdthinProzents * 11,
                    //   child: Text(
                    //     '${widget.project.projectNumber} EUR',
                    //     textAlign: TextAlign.right,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: screenWihdthinProzents * 11,
                    //   child: Text(
                    //     '${widget.project.totalTime} EUR',
                    //     textAlign: TextAlign.right,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: screenWihdthinProzents * 11,
                    //   child: Text(
                    //     '${widget.project.costItems} EUR',
                    //     textAlign: TextAlign.right,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 260,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.project.customer,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '${widget.project.revenue} EUR',
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Icon(widget.isContainerOpen
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            if (widget.isContainerOpen)
              const Row(
                children: [
                  Flexible(
                    flex: 5, // 20%
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Berlin AG",
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
